package Repository;
import Model.PrgState;
import Model.adt.MyList;

import java.io.BufferedWriter;
import java.io.FileWriter;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

public class Repo implements IRepo{
    List<PrgState> myPrgStates;
    int currentPrgIndex;
    private String logPath;
    private PrintWriter printWriter;

    public Repo(String fileName){
        this.myPrgStates = new ArrayList<>();
        this.currentPrgIndex = 0;
        this.logPath = "D:\\facultate\\map\\lab\\a7\\" + fileName;
    }

    @Override
    public void addPrg(PrgState newPrg){
        this.myPrgStates.add(newPrg);
    }

    @Override
    public PrgState getSpecificPrg(int index){
        return this.myPrgStates.get(index);
    }

    @Override
    public List<PrgState> getPrgList(){
        return this.myPrgStates;
    }

    @Override
    public void setPrgList(List<PrgState> states){
        this.myPrgStates = states;
    }

    @Override
    public void logPrgStateExec(PrgState state){
        try{
            this.printWriter = new PrintWriter(new BufferedWriter(new FileWriter(this.logPath, true)));
            printWriter.println("ID: ");
            printWriter.println(state.getProgramId());
            printWriter.println("Execution stack: ");
            printWriter.println(state.getExeStack().toString());
            printWriter.println("Symbol table: ");
            printWriter.println(state.getSymTable().toString());
            printWriter.println("Output: ");
            printWriter.println(state.getOut().toString());
            printWriter.println("File table: ");
            printWriter.println(state.getFileTable().toString());
            printWriter.println("Heap: ");
            printWriter.println(state.getHeap().toString());
            printWriter.println(" ");
            printWriter.close();
        }
        catch (java.io.IOException e){
            System.out.println(e.toString());
        }
    }

    @Override
    public PrgState getPrgID(int id) {
        for (PrgState p: this.myPrgStates) {
            if (p.getProgramId() == id) {
                return p;
            }
        }
        return null;
    }
}
