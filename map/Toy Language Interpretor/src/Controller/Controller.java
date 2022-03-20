package Controller;
import Model.PrgState;
import Model.adt.IDict;
import Model.adt.MyDict;
import Model.types.IType;
import Model.types.IntType;
import Model.value.IValue;
import Model.value.RefValue;
import Repository.IRepo;
import Model.adt.IStack;
import Model.stmt.IStmt;
import Exception.CustomException;

import java.io.IOException;
import java.util.Collection;
import java.util.List;
import java.util.Map;
import java.util.concurrent.*;
import java.util.stream.Collectors;
import java.util.stream.Stream;


public class Controller {
    IRepo repo;
    private ExecutorService executor;

    public Controller(IRepo repo){
        this.repo = repo;
    }

    public IRepo getRepo(){
        return this.repo;
    }

    public void addProgram(PrgState newPrg){
        this.repo.addPrg(newPrg);
    }

    public void allStep() throws InterruptedException{
        this.executor = Executors.newFixedThreadPool(2);
        List<PrgState> states = removeCompletedPrg(this.repo.getPrgList());
        while(states.size() > 0){
            callGarbageCollector(states);
            oneStepForAllPrg(states);
            states = removeCompletedPrg(this.repo.getPrgList());
        }
        this.executor.shutdownNow();
        states = removeCompletedPrg(this.repo.getPrgList());
        this.repo.setPrgList(states);
    }

    public void oneStep(){
        this.executor = Executors.newFixedThreadPool(2);
        this.repo.setPrgList(removeCompletedPrg(repo.getPrgList()));
        List<PrgState> states = this.repo.getPrgList();
        if (states.size() > 0){
            try {
                this.oneStepForAllPrg(states);
            } catch(InterruptedException e){
                System.out.println(e);
            }
            this.repo.setPrgList(removeCompletedPrg(repo.getPrgList()));
            this.executor.shutdownNow();
            callGarbageCollector(states);
        }
    }

    public void oneStepForAllPrg(List<PrgState> states) throws InterruptedException{
        states.forEach(p-> {
                this.repo.logPrgStateExec(p);
        });
        List<Callable<PrgState>> callableList = states.stream()
                .map((PrgState p) -> (Callable<PrgState>)(()-> p.oneStep()))
                .collect(Collectors.toList());
        List<PrgState> newStates = executor.invokeAll(callableList)
                .stream()
                .map(future -> {
                    try{
                        return future.get();
                    }catch (InterruptedException | ExecutionException e){
                        System.out.println(e.getMessage());
                        return null;
                    }
                })
                .filter(e -> e != null)
                .collect(Collectors.toList());
        states.addAll(newStates);
        states.forEach(p -> {
                this.repo.logPrgStateExec(p);
        });
        this.repo.setPrgList(states);

    }

    public Map<Integer,IValue> safeGarbageCollector(List<Integer> symTableValues, Map<Integer, IValue> heap) {
        return heap.entrySet().stream()
                .filter(e->symTableValues.contains(e.getKey()))
                .collect(Collectors.toMap(Map.Entry::getKey, Map.Entry::getValue));
    }

    List<Integer> getAddrFromSymTable(Collection<IValue> symTableValues, Collection<IValue> heap) {
        return Stream.concat(
                        heap.stream()
                                .filter(v -> v instanceof RefValue)
                                .map(v -> {
                                    RefValue v1 = (RefValue) v;
                                    return v1.getAddress();
                                }),
                        symTableValues.stream()
                                .filter(v -> v instanceof RefValue)
                                .map(v -> {
                                    RefValue v1 = (RefValue) v;
                                    return v1.getAddress();
                                })
                )
                .collect(Collectors.toList());
    }

    public List<PrgState> removeCompletedPrg(List<PrgState> inPrgList){
        return inPrgList.stream()
                .filter(p -> p.isNotCompleted())
                .collect(Collectors.toList());
    }

    public void callGarbageCollector(List<PrgState> states){
        states.forEach(
                p -> {
                    p.getHeap().setContent(safeGarbageCollector(getAddrFromSymTable(p.getSymTable().getDict().values(), p.getHeap().getContent().values()), p.getHeap().getContent()));
                }
        );
    }
}
