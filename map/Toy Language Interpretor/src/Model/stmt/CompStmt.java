package Model.stmt;
import Model.PrgState;
import Model.adt.IDict;
import Model.adt.IStack;
import Model.types.IType;
import Exception.CustomException;

public class CompStmt implements IStmt{

    IStmt st1, st2;

    public CompStmt(IStmt st1, IStmt st2){
        this.st1 = st1;
        this.st2 = st2;
    }

    @Override
    public PrgState execute(PrgState state){
        IStack<IStmt> exeStack = state.getExeStack();
        exeStack.push(this.st2);
        exeStack.push(this.st1);
        return null;
    }

    @Override
    public String toString(){
        return "(" + this.st1.toString() + "; " + this.st2.toString() + ")";
    }

    @Override
    public IStmt deepCopy(){
        return new CompStmt(this.st1, this.st2);
    }

    @Override
    public IDict<String, IType> typecheck(IDict<String, IType> typeEnv) throws CustomException{
        return this.st2.typecheck(this.st1.typecheck(typeEnv));
    }
}
