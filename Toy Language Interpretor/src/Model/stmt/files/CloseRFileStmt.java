package Model.stmt.files;

import Model.PrgState;
import Model.adt.IDict;
import Model.exp.IExp;
import Model.stmt.IStmt;
import Model.types.IType;
import Model.types.StringType;
import Model.value.IValue;
import Model.value.StringValue;
import Exception.CustomException;
import java.io.BufferedReader;
import java.io.IOException;

public class CloseRFileStmt implements IStmt {
    private final IExp fileExpression;

    public CloseRFileStmt(IExp fileExpression){
        this.fileExpression = fileExpression;
    }

    @Override
    public PrgState execute(PrgState state){
        if (!this.fileExpression.evaluate(state.getSymTable(), state.getHeap()).getType().equals(new StringType()))
            throw new CustomException("File name is not a string");
        StringValue fn = (StringValue)this.fileExpression.evaluate(state.getSymTable(), state.getHeap());
        BufferedReader br = state.getFileTable().lookup(fn);

        if (br == null) {
            throw new CustomException("File not opened!");
        }

        try {
            br.close();
            state.getFileTable().remove(fn);

        } catch (java.io.IOException e) {
            System.out.println(e.toString());
        }

        return null;
    }

    @Override
    public String toString(){
        return "closeRFile(" + this.fileExpression.toString() + ")";
    }

    @Override
    public IStmt deepCopy(){
        return new CloseRFileStmt(this.fileExpression);
    }

    @Override
    public IDict<String, IType> typecheck(IDict<String, IType> typeEnv) throws CustomException{
        IType typeexp = this.fileExpression.typecheck(typeEnv);
        if (typeexp.equals(new StringType()))
            return typeEnv;
        else throw new CustomException("CloseRFile stmt: expression type is not a string");
    }
}
