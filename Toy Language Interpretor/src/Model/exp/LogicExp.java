package Model.exp;

import Model.adt.IDict;
import Model.adt.IHeap;
import Model.types.BoolType;
import Model.types.IType;
import Model.types.IntType;
import Model.value.BoolValue;
import Model.value.IValue;
import Exception.CustomException;

public class LogicExp implements IExp{
    char operator;
    IExp e1, e2;

    public LogicExp(char operator, IExp e1, IExp e2){
        this.e1 = e1;
        this.e2 = e2;
        this.operator = operator;
    }

    @Override
    public IValue evaluate(IDict<String, IValue> symTable, IHeap<IValue> heap){
        IValue v1, v2;
        v1 = e1.evaluate(symTable, heap);
        if (v1.getType().equals(new BoolType())){
            v2 = e2.evaluate(symTable, heap);
            if (v2.getType().equals(new BoolType())){
                boolean n1, n2;
                n1 = ((BoolValue)v1).getValue();
                n2 = ((BoolValue)v2).getValue();
                switch (this.operator){
                    case '&':
                        return new BoolValue(n1 && n2);
                    case '|':
                        return new BoolValue(n1 || n2);
                    default:
                        throw new CustomException("Invalid operation");
                }
            }
            else throw new CustomException("Second operand is not a boolean");
        }
        else throw new CustomException("First operand is not a boolean");
    }

    @Override
    public String toString(){
        return this.e1.toString() + " " + this.operator + " " + this.e2.toString();
    }

    @Override
    public IExp deepCopy(){
        return new LogicExp(this.operator, this.e1, this.e2);
    }

    @Override
    public IType typecheck(IDict<String, IType> typeEnv) throws CustomException{
        IType type1, type2;
        type1 = this.e1.typecheck(typeEnv);
        type2 = this.e2.typecheck(typeEnv);
        if (type1.equals(new BoolType())){
            if (type2.equals(new BoolType()))
                return new BoolType();
            else throw new CustomException("second operand is not a boolean");
        }
        else throw new CustomException("first operand is not a boolean");
    }
}
