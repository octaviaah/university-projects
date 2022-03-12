package Model;
import Model.adt.*;
import Model.stmt.IStmt;
import Model.value.IValue;
import Model.value.StringValue;

import java.io.BufferedReader;
import java.util.HashMap;
import Exception.CustomException;

public class PrgState {
    private IStack<IStmt> exeStack;
    private IList<IValue> out;
    private IDict<String, IValue> symTable;
    private IDict<StringValue, BufferedReader> fileTable;
    private IHeap<IValue> heap;
    private IStmt originalProgram;
    private int programId;
    private static int id = 1;

    public PrgState(IStmt program){
        this.exeStack = new MyStack<>();
        this.out = new MyList<>();
        this.symTable = new MyDict<>();
        this.fileTable = new MyDict<>();
        this.heap = new MyHeap<IValue>(new HashMap<Integer, IValue>());
        this.originalProgram = program;
        this.programId = 1;
        this.exeStack.push(program);
    }

    public PrgState(IStmt program, IStack<IStmt> exeStack, IList<IValue> out, IDict<String, IValue> symTable, IDict<StringValue, BufferedReader> fileTable, IHeap<IValue> heap){
        this.exeStack = exeStack;
        this.out = out;
        this.symTable = symTable;
        this.fileTable = fileTable;
        this.heap = heap;
        this.originalProgram = program;
        this.programId = getId();
        this.exeStack.push(program);
    }

    public IStack<IStmt> getExeStack(){
        return this.exeStack;
    }

    public void setExeStack(IStack<IStmt> exeStack){
        this.exeStack = exeStack;
    }

    public IList<IValue> getOut(){
        return this.out;
    }

    public void setOut(IList<IValue> out){
        this.out = out;
    }

    public IDict<String, IValue> getSymTable(){
        return this.symTable;
    }

    public void setSymTable(IDict<String, IValue> symTable){
        this.symTable = symTable;
    }

    public IDict<StringValue, BufferedReader> getFileTable(){
        return this.fileTable;
    }

    public void setFileTable(IDict<StringValue, BufferedReader> fileTable){
        this.fileTable = fileTable;
    }

    public IHeap<IValue> getHeap(){
        return this.heap;
    }

    public void setHeap(IHeap<IValue> heap){
        this.heap = heap;
    }

    public IStmt getOriginalProgram(){
        return this.originalProgram;
    }

    public void setOriginalProgram(IStmt program){
        this.originalProgram = program;
    }

    public int getProgramId(){
        return this.programId;
    }

    public void setProgramId(int id){
        this.programId = id;
    }

    public boolean isNotCompleted(){
        return !this.exeStack.isEmpty();
    }

    public PrgState oneStep(){
        if (this.exeStack.isEmpty())
            throw new CustomException("Execution stack is empty!");
        IStmt currentStatement = this.exeStack.pop();
        return currentStatement.execute(this);
    }

    public synchronized int getId(){
        id += 1;
        return id;
    }

    public String toString(){
        String s = "";
        s += "ID:\n";
        s += this.programId;
        s += "\n";
        s += "exeStack:\n";
        s += this.exeStack.toString();
        s += "\n";
        s += "symTable:\n";
        s += this.symTable.toString();
        s += "\n";
        s += "out:\n";
        s += this.out.toString();
        s += "\n";
        s += "fileTable:\n";
        s += this.fileTable.toString();
        s += "\n";
        s += "heap:\n";
        s += this.heap.toString();
        s += "\n";
        return s;
    }
}

