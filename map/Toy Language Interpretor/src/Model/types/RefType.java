package Model.types;

import Model.value.IValue;
import Model.value.RefValue;

public class RefType implements IType{
    IType inner;
    public RefType(IType inner){
        this.inner = inner;
    }

    public IType getInner(){
        return this.inner;
    }

    @Override
    public IValue defaultValue(){
        return new RefValue(0, inner);
    }

    @Override
    public boolean equals(Object o) {
        if (o instanceof RefType)
            return inner.equals(((RefType) o).getInner());
        return false;
    }

    @Override
    public IType deepCopy(){
        return new RefType(this.inner);
    }

    @Override
    public String toString(){
        return "ref( "+this.inner.toString() + " )";
    }
}
