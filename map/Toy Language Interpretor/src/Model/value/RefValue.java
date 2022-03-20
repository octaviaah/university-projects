package Model.value;

import Model.types.IType;
import Model.types.IntType;
import Model.types.RefType;

public class RefValue implements IValue{
    int address;
    IType locationType;

    public RefValue(IType locationType){
        this.address = 0;
        this.locationType = locationType;
    }

    public RefValue(int address, IType locationType){
        this.address = address;
        this.locationType = locationType;
    }

    @Override
    public boolean equals(Object o){
        if (o == null || o.getClass() != this.getClass())
            return false;
        RefValue oValue = (RefValue) o;
        return oValue.address == this.address && oValue.locationType == this.locationType;
    }

    @Override
    public String toString(){
        return "("+ this.address +","+ this.locationType.toString() + ")";
    }

    @Override
    public IType getType(){
        return new RefType(locationType);
    }

    public IType getLocationType(){
        return this.locationType;
    }

    public int getAddress(){
        return this.address;
    }

    @Override
    public IValue deepCopy(){
        return new RefValue(this.address, this.locationType);
    }
}
