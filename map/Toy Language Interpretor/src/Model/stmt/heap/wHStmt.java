package Model.stmt.heap;

import Model.PrgState;
import Model.adt.IDict;
import Model.exp.IExp;
import Model.stmt.IStmt;
import Model.types.IType;
import Model.types.IntType;
import Model.types.RefType;
import Model.value.IValue;
import Model.value.IntValue;
import Exception.CustomException;
import Model.value.RefValue;

public class wHStmt implements IStmt {
    private String var_name;
    private IExp exp;

    public wHStmt(String var_name, IExp exp){
        this.var_name = var_name;
        this.exp = exp;
    }

    @Override
    public PrgState execute(PrgState state){
        if (!state.getSymTable().isKey(this.var_name))
            throw new CustomException("Variable does not exist");
        IValue var_val = state.getSymTable().lookup(this.var_name);
        if (!(var_val instanceof RefValue))
            throw new CustomException("Variable is not a RefValue");
        int address = ((RefValue)var_val).getAddress();
        if (state.getHeap().getAddress(address) == null)
            throw new CustomException("Adress is not in the heap");
        IValue val = this.exp.evaluate(state.getSymTable(), state.getHeap());
        if (!(val.getType().equals(((RefValue)var_val).getLocationType())))
            throw new CustomException("Incompatible types write");
        state.getHeap().addAddress(address, val);
        return null;
    }

    @Override
    public String toString(){
        return "wH(" + this.var_name + ", " + this.exp.toString() + ")";
    }

    @Override
    public IStmt deepCopy(){
        return new wHStmt(this.var_name, this.exp);
    }

    @Override
    public IDict<String, IType> typecheck(IDict<String, IType> typeEnv) throws CustomException{
        IType typevar = typeEnv.lookup(this.var_name);
        IType typeexp = this.exp.typecheck(typeEnv);
        if (typevar.equals(new RefType(typeexp)))
            return typeEnv;
        else throw new CustomException("wH stmt: different types");
    }
}
