package Model.stmt;
import Model.PrgState;
import Model.adt.IDict;
import Model.adt.IList;
import Model.exp.IExp;
import Model.types.IType;
import Model.value.IValue;
import Exception.CustomException;

public class PrintStmt implements IStmt{
    IExp expression;

    public PrintStmt(IExp exp){
        this.expression = exp;
    }

    public PrgState execute(PrgState state){
        IList<IValue> out = state.getOut();
        out.add(expression.evaluate(state.getSymTable(), state.getHeap()));
        state.setOut(out);
        return null;
    }

    @Override
    public String toString(){
        return "print(" + this.expression.toString() + ")";
    }

    @Override
    public IStmt deepCopy(){
        return new PrintStmt(this.expression);
    }

    @Override
    public IDict<String, IType> typecheck(IDict<String, IType> typeEnv) throws CustomException{
        this.expression.typecheck(typeEnv);
        return typeEnv;
    }
}
