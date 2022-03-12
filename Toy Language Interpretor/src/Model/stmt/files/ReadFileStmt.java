package Model.stmt.files;

import Model.PrgState;
import Model.adt.IDict;
import Model.exp.IExp;
import Model.stmt.IStmt;
import Model.types.IType;
import Model.types.IntType;
import Model.types.StringType;
import Model.value.IValue;
import Model.value.IntValue;
import Model.value.StringValue;
import Exception.CustomException;
import java.io.BufferedReader;
import java.io.IOException;

public class ReadFileStmt implements IStmt {
    private final IExp fileExpression;
    private final String var_name;

    public ReadFileStmt(IExp fileExpression, String var_name){
        this.fileExpression = fileExpression;
        this.var_name = var_name;
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

        String line = "";
        try {
            line = br.readLine();
        } catch (java.io.IOException e) {
            System.out.println(e.toString());
        }
        System.out.println(line);
        int val = 0;
        if (line != null) {
            val = Integer.valueOf(line);
        }

        state.getSymTable().add(this.var_name, new IntValue(val));
        return null;
    }

    @Override
    public String toString(){
        return "readFile(" + this.fileExpression.toString() + " " + this.var_name + ")";
    }

    @Override
    public IStmt deepCopy(){
        return new ReadFileStmt(this.fileExpression, this.var_name);
    }

    @Override
    public IDict<String, IType> typecheck(IDict<String, IType> typeEnv) throws CustomException{
        IType typevar = typeEnv.lookup(this.var_name);
        IType typeexp = this.fileExpression.typecheck(typeEnv);
        if (typevar.equals(new IntType())) {
            if (typeexp.equals(new StringType()))
                return typeEnv;
            else throw new CustomException("ReadFile stmt: expression is not a string");
        }
       else throw new CustomException("ReadFile stmt: variable not of type integer");
    }
}
