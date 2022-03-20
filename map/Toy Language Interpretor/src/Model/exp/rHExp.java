package Model.exp;

import Model.adt.IDict;
import Model.adt.IHeap;
import Model.types.BoolType;
import Model.types.IntType;
import Model.types.RefType;
import Model.types.StringType;
import Model.value.IValue;
import Model.value.RefValue;
import Exception.CustomException;
import Model.types.IType;

public class rHExp implements IExp{
    private IExp exp;

    public rHExp(IExp exp){
        this.exp = exp;
    }

    @Override
    public IValue evaluate(IDict<String, IValue> symTable, IHeap<IValue> heap){
        IValue val = this.exp.evaluate(symTable, heap);
        if (!(val instanceof RefValue))
            throw new CustomException("Value is not a RefValue");
        RefValue ref_val = (RefValue) val;
        if (heap.getAddress(ref_val.getAddress()) == null)
            throw new CustomException("Address is not a key in the heap");
        IValue heap_val = heap.getAddress(ref_val.getAddress());
        return heap_val;
    }

    @Override
    public String toString(){
        return this.exp.toString();
    }

    @Override
    public IExp deepCopy(){
        return new rHExp(this.exp);
    }

    @Override
    public IType typecheck(IDict<String, IType> typeEnv) throws CustomException{
        IType type = this.exp.typecheck(typeEnv);
        if (type instanceof RefType){
            RefType reft = (RefType) type;
            return reft.getInner();
        }
        else throw new CustomException("the rH argument is not a RefType");
    }
}
