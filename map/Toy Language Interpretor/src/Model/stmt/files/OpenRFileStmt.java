package Model.stmt.files;

import Model.PrgState;
import Model.adt.IDict;
import Model.adt.IPair;
import Model.stmt.IStmt;
import Exception.CustomException;
import java.io.BufferedReader;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileReader;
import Model.exp.IExp;
import Model.types.IType;
import Model.types.StringType;
import Model.value.IValue;
import Model.value.IntValue;
import Model.value.StringValue;

public class OpenRFileStmt implements IStmt {
    private IExp exp;

    public OpenRFileStmt(IExp exp) {
        this.exp = exp;
    }

    @Override
    public PrgState execute(PrgState state){
        IValue evValue;
        evValue = this.exp.evaluate(state.getSymTable(), state.getHeap());
        if (evValue.getType().equals(new StringType())){
            StringValue value = (StringValue) evValue;
            if (!state.getFileTable().isKey(value)){
                try {
                    BufferedReader fileDescriptor = new BufferedReader(new FileReader("D:\\facultate\\map\\lab\\a7\\" + value.getValue()));
                    state.getFileTable().add(value, fileDescriptor);
                    state.getSymTable().add(this.exp.toString(), value);
                }catch(FileNotFoundException e)
                {
                    System.out.println(e);
                }
            }
            else throw new CustomException("Filename already exists!");
        }
        else throw new CustomException("Exp is not a StringValue");
        return null;
    }

    @Override
    public String toString(){
        return "openRFile(" + this.exp.toString() + ")";
    }

    @Override
    public IStmt deepCopy(){
        return new OpenRFileStmt(this.exp);
    }

    @Override
    public IDict<String, IType> typecheck(IDict<String, IType> typeEnv) throws CustomException{
        IType typeexp = this.exp.typecheck(typeEnv);
        if (typeexp.equals(new StringType()))
            return typeEnv;
        else throw new CustomException("OpenRFile stmt - exp not a string");
    }
}
