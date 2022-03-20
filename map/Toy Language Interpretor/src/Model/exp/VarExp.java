package Model.exp;
import Model.adt.IDict;
import Model.adt.IHeap;
import Model.types.IType;
import Model.value.IValue;
import Exception.CustomException;

public class VarExp implements IExp{
    String name;

    public VarExp(String name){
        this.name = name;
    }

    @Override
    public IValue evaluate(IDict<String, IValue> symTable, IHeap<IValue> heap){
        if (symTable.isKey(this.name))
            return symTable.lookup(this.name);
        else throw new CustomException("There is no such key");
    }

    public String toString(){
        return this.name;
    }

    @Override
    public IExp deepCopy(){
        return new VarExp(this.name);
    }

    @Override
    public IType typecheck(IDict<String , IType> typeEnv) throws CustomException{
        return typeEnv.lookup(this.name);
    }
}
