package Model.stmt;
import Model.PrgState;
import Model.adt.IDict;
import Model.adt.IHeap;
import Model.adt.IStack;
import Model.exp.IExp;
import Model.types.IType;
import Model.value.IValue;
import Exception.CustomException;

public class AssignStmt implements IStmt{
    String id;
    IExp expression;

    public AssignStmt(String id, IExp expression){
        this.id = id;
        this.expression = expression;
    }

    @Override
    public PrgState execute(PrgState state){
        IStack exeStack = state.getExeStack();
        IDict<String, IValue> symTable = state.getSymTable();
        IHeap<IValue> heap = state.getHeap();
        if (symTable.isKey(this.id)) {
            IValue val = this.expression.evaluate(symTable, heap);
            IType typeId = (symTable.lookup(this.id)).getType();
            if (val.getType().equals(typeId)){
                symTable.update(this.id, this.expression.evaluate(symTable, heap));
                state.setSymTable(symTable);
            }
            else throw new CustomException("the type of the assigned variable and the declared type do not match");
        }
        else throw new CustomException("the used variable does not exist");
        return null;
    }

    @Override
    public String toString(){
        return this.id + " = " + this.expression.toString();
    }

    @Override
    public IStmt deepCopy(){
        return new AssignStmt(this.id, this.expression);
    }

    @Override
    public IDict<String, IType> typecheck(IDict<String, IType> typeEnv) throws CustomException{
        IType typevar = typeEnv.lookup(this.id);
        IType typeexp = this.expression.typecheck(typeEnv);
        if (typevar.equals(typeexp))
            return typeEnv;
        else throw new CustomException("Assignment: rhs and lhs have different types");
    }
}
