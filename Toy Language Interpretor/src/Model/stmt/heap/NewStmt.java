package Model.stmt.heap;

import Model.PrgState;
import Model.adt.IDict;
import Model.exp.IExp;
import Model.stmt.IStmt;
import Model.stmt.IfStmt;
import Model.types.IType;
import Model.types.RefType;
import Model.value.IValue;
import Model.value.IntValue;
import Exception.CustomException;
import Model.value.RefValue;

public class NewStmt implements IStmt {
    private String var_name;
    private IExp exp;

    public NewStmt(String var_name, IExp exp){
        this.var_name = var_name;
        this.exp = exp;
    }

    @Override
    public PrgState execute(PrgState state){
        if(!state.getSymTable().isKey(var_name))
            throw new CustomException("Variable is not defined");
        IValue var_val = state.getSymTable().lookup(var_name);
        if (!(var_val instanceof RefValue))
            throw new CustomException("Variable is not a RefValue");
        IValue result = this.exp.evaluate(state.getSymTable(), state.getHeap());
        if (!(result.getType().equals(((RefValue) var_val).getLocationType())))
            throw new CustomException("Incompatible types new");
        int loc = state.getHeap().allocate(result);
        state.getSymTable().update(var_name, new RefValue(loc, result.getType()));
        return null;
    }

    @Override
    public String toString(){
        return "newStmt(" + this.var_name + ", " + this.exp.toString() + ")";
    }

    @Override
    public IStmt deepCopy(){
        return new NewStmt(this.var_name, this.exp);
    }

    @Override
    public IDict<String, IType> typecheck(IDict<String, IType> typeEnv) throws CustomException{
        IType typevar = typeEnv.lookup(this.var_name);
        IType typeexp = this.exp.typecheck(typeEnv);
        if (typevar.equals(new RefType(typeexp)))
            return typeEnv;
        else throw new CustomException("New stmt: rhs and lhs have different types");
    }
}
