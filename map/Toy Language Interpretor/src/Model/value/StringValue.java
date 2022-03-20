package Model.value;
import Model.types.IType;
import Model.types.StringType;

public class StringValue implements IValue{
    String value;

    public StringValue(){
        this.value = "";
    }

    public StringValue(String s){
        this.value = s;
    }

    @Override
    public boolean equals(Object o){
        if (o == null || o.getClass() != this.getClass())
            return false;
        StringValue oValue = (StringValue) o;
        return oValue.value == this.value;
    }

    @Override
    public String toString(){
        return this.value;
    }

    @Override
    public IType getType(){
        return new StringType();
    }

    public String getValue(){
        return this.value;
    }

    @Override
    public IValue deepCopy(){
        return new StringValue(this.value);
    }
}