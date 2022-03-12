package Model.stmt;

import Model.PrgState;
import Model.adt.IDict;
import Model.adt.MyStack;
import Model.types.BoolType;
import Model.types.IType;
import Exception.CustomException;

public class ForkStmt implements IStmt{
    private IStmt stmt;

    public ForkStmt(IStmt stmt){
        this.stmt = stmt;
    }

    @Override
    public PrgState execute(PrgState state){
        return new PrgState(stmt, new MyStack<>(), state.getOut(), state.getSymTable().copy(), state.getFileTable(), state.getHeap());
    }

    @Override
    public String toString(){
        return "fork(" + this.stmt.toString() + ")";
    }

    @Override
    public IStmt deepCopy(){
        return new ForkStmt(this.stmt);
    }

    @Override
    public IDict<String, IType> typecheck(IDict<String, IType> typeEnv) throws CustomException {
        this.stmt.typecheck(typeEnv.copy());
        return typeEnv;
    }
}
