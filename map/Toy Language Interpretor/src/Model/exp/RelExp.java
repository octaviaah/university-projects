package Model.exp;

import Model.adt.IDict;
import Model.adt.IHeap;
import Model.types.IType;
import Model.types.IntType;
import Model.value.BoolValue;
import Model.value.IValue;
import Model.value.IntValue;
import Exception.CustomException;

public class RelExp implements IExp{
    String operator;
    IExp e1, e2;

    public RelExp(String operator, IExp e1, IExp e2){
        this.e1 = e1;
        this.e2 = e2;
        this.operator = operator;
    }

    @Override
    public IValue evaluate(IDict<String, IValue> symTable, IHeap<IValue> heap){
        IValue v1, v2;
        v1 = e1.evaluate(symTable, heap);
        if (v1.getType().equals(new IntType())){
            v2 = e2.evaluate(symTable, heap);
            if (v2.getType().equals(new IntType())) {
                int n1, n2;
                n1 = ((IntValue)v1).getValue();
                n2 = ((IntValue)v2).getValue();
                switch (this.operator) {
                    case "<":
                        return new BoolValue(n1 < n2);
                    case "<=":
                        return new BoolValue(n1 <= n2);
                    case "==":
                        return new BoolValue(n1 == n2);
                    case "!=":
                        return new BoolValue(n1 != n2);
                    case ">":
                        return new BoolValue(n1 > n2);
                    case ">=":
                        return new BoolValue(n1 >= n2);
                    default:
                        throw new CustomException("Invalid operation");
                }
            }
            else throw new CustomException("Second operand is not an integer");
        }
        else throw new CustomException("First operand is not an integer");
    }

    @Override
    public String toString(){
        return this.e1.toString() + " " + this.operator + " " + this.e2.toString();
    }

    @Override
    public IExp deepCopy(){
        return new RelExp(this.operator, this.e1, this.e2);
    }

    @Override
    public IType typecheck(IDict<String, IType> typeEnv) throws CustomException{
        IType type1, type2;
        type1 = this.e1.typecheck(typeEnv);
        type2 = this.e2.typecheck(typeEnv);
        if (type1.equals(new IntType())){
            if (type2.equals(new IntType()))
                return new IntType();
            else throw new CustomException("second operand is not an integer");
        }
        else throw new CustomException("first operand is not an integer");
    }
}
