package Model.stmt;

import Model.adt.IDict;
import Model.adt.IStack;
import Model.exp.IExp;
import Model.PrgState;
import Model.types.BoolType;
import Model.types.IType;
import Model.types.IntType;
import Model.value.BoolValue;
import Model.value.IValue;
import Exception.CustomException;

public class WhileStmt implements IStmt{
    private IExp exp;
    private IStmt stmt;

    public WhileStmt(IExp exp, IStmt stmt){
        this.exp = exp;
        this.stmt = stmt;
    }

    @Override
    public PrgState execute(PrgState state){
        IStack<IStmt> exeStack = state.getExeStack();
        IValue result = this.exp.evaluate(state.getSymTable(), state.getHeap());
        if (result.getType().equals(new BoolType()))
        {
            if(((BoolValue) result).getValue()) {
                exeStack.push(this);
                exeStack.push(this.stmt);
            }
        }
        else throw new CustomException("Expression doesn't have a BoolValue");
        return null;
    }

    @Override
    public String toString(){
        return "while(" + this.exp.toString() + ") do" + this.stmt.toString() + " end";
    }

    @Override
    public IStmt deepCopy(){
        return new WhileStmt(this.exp, this.stmt);
    }

    @Override
    public IDict<String, IType> typecheck(IDict<String, IType> typeEnv) throws CustomException{
        IType typeexp = this.exp.typecheck(typeEnv);
        if (typeexp.equals(new IntType())) {
            this.stmt.typecheck(typeEnv.copy());
            return typeEnv;
        }
        else throw new CustomException("The condition of While doesn't have the type integer");
    }
}
