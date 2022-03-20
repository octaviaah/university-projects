package Repository;
import Model.PrgState;
import Model.adt.MyList;

import java.util.List;

public interface IRepo {
    void addPrg(PrgState newPrg);
    PrgState getSpecificPrg(int index);
    void logPrgStateExec(PrgState state);
    List<PrgState> getPrgList();
    void setPrgList(List<PrgState> states);
    PrgState getPrgID(int id);
}
