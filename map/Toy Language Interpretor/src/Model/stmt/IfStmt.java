package Model.stmt;
import Model.adt.IDict;
import Model.exp.IExp;
import Model.PrgState;
import Model.types.BoolType;
import Model.types.IType;
import Model.types.IntType;
import Model.value.*;
import Exception.CustomException;

public class IfStmt implements IStmt{

    IExp expression;
    IStmt st1, st2;

    public IfStmt(IExp expression, IStmt st1, IStmt st2){
        this.expression = expression;
        this.st1 = st1;
        this.st2 = st2;
    }

    @Override
    public PrgState execute(PrgState state){
        IValue result = this.expression.evaluate(state.getSymTable(), state.getHeap());
        if(result.getType().equals(new IntType())) {
            int r1 = ((IntValue)result).getValue();
            if (r1 != 0)
                this.st1.execute(state);
            else this.st2.execute(state);
        }
        else{
            boolean r2 = ((BoolValue)result).getValue();
            if (r2 != false)
                this.st1.execute(state);
            else this.st2.execute(state);
        }
        return null;
    }

    @Override
    public String toString(){
        return "if " + this.expression.toString() + " then " +  this.st1.toString() + " else " + this.st2.toString();
    }

    @Override
    public IStmt deepCopy(){
        return new IfStmt(this.expression, this.st1, this.st2);
    }

    @Override
    public IDict<String, IType> typecheck(IDict<String, IType> typeEnv) throws CustomException{
        IType typeexp = this.expression.typecheck(typeEnv);
        if (typeexp.equals(new BoolType())) {
            this.st1.typecheck(typeEnv.copy());
            this.st2.typecheck(typeEnv.copy());
            return typeEnv;
        }
        else throw new CustomException("The condition of If doesn't have the type boolean");
    }
}
