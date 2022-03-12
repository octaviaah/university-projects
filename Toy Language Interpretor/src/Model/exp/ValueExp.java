package Model.exp;
import Model.adt.IDict;
import Model.adt.IHeap;
import Model.types.IType;
import Model.value.IValue;
import Exception.CustomException;

public class ValueExp implements IExp{
    IValue value;

    public ValueExp(IValue value){
        this.value = value;
    }

    @Override
    public IValue evaluate(IDict<String, IValue> symTable, IHeap<IValue> heap){
        return this.value;
    }

    @Override
    public String toString(){
        return this.value.toString();
    }

    @Override
    public IExp deepCopy(){
        return new ValueExp(this.value);
    }

    @Override
    public IType typecheck(IDict<String, IType> typeEnv) throws CustomException{
        return this.value.getType();
    }
}
