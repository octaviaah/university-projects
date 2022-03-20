package Model.value;
import Model.types.BoolType;
import Model.types.IType;

public class BoolValue implements IValue{

    boolean value;

    public BoolValue(){
        this.value = false;
    }

    public BoolValue(boolean b){
        this.value = b;
    }

    @Override
    public boolean equals(Object o){
        if (o == null || o.getClass() != this.getClass())
            return false;
        BoolValue oValue = (BoolValue) o;
        return oValue.value == this.value;
    }

    public boolean getValue(){
        return this.value;
    }

    @Override
    public String toString(){
        return this.value ? "true" : "false";
    }

    @Override
    public IType getType(){
        return new BoolType();
    }

    @Override
    public IValue deepCopy(){
        return new BoolValue(this.value);
    }
}
