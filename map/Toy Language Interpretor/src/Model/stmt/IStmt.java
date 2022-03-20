package Model.stmt;
import Model.PrgState;
import Model.adt.IDict;
import Model.adt.MyDict;
import Model.types.IType;
import Exception.CustomException;

import java.io.FileNotFoundException;

public interface IStmt {
    PrgState execute(PrgState state);

    @Override
    String toString();
    IStmt deepCopy();
    IDict<String, IType> typecheck(IDict<String, IType> typeEnv) throws CustomException;
}
