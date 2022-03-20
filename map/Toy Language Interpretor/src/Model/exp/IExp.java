package Model.exp;
import Model.adt.IDict;
import Model.adt.IHeap;
import Model.types.IType;
import Model.value.IValue;
import Exception.CustomException;

public interface IExp {
    IValue evaluate(IDict<String, IValue> symTable, IHeap<IValue> heap);
    String toString();
    IExp deepCopy();
    IType typecheck(IDict<String, IType> typeEnv) throws CustomException;
}
