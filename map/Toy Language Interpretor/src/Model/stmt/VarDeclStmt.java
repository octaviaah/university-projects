package Model.stmt;
import Model.PrgState;
import Model.adt.IDict;
import Model.types.IType;
import Model.value.IValue;
import Exception.CustomException;

public class VarDeclStmt implements IStmt{
    String name;
    IType type;

    public VarDeclStmt(String name, IType type){
        this.name = name;
        this.type = type;
    }

    @Override
    public PrgState execute(PrgState state){
        IDict<String, IValue> symTable = state.getSymTable();
        if (symTable.isKey(name)) throw new CustomException("variable already declared");
        else
            symTable.add(name, this.type.defaultValue());
        state.setSymTable(symTable);
        return null;
    }

    @Override
    public String toString(){
        return this.type + " " + this.name;
    }

    @Override
    public IStmt deepCopy(){
        return new VarDeclStmt(this.name, this.type);
    }

    @Override
    public IDict<String, IType> typecheck(IDict<String, IType> typeEnv) throws CustomException{
        typeEnv.add(this.name, this.type);
        return typeEnv;
    }
}
