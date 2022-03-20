package View;

import Controller.Controller;
import Model.PrgState;
import Model.adt.MyDict;
import Model.exp.*;
import Model.stmt.*;
import Model.stmt.files.CloseRFileStmt;
import Model.stmt.files.OpenRFileStmt;
import Model.stmt.files.ReadFileStmt;
import Model.stmt.heap.NewStmt;
import Model.stmt.heap.wHStmt;
import Model.types.*;
import Model.value.BoolValue;
import Model.value.IntValue;
import Model.value.StringValue;
import Repository.IRepo;
import Repository.Repo;
import Exception.CustomException;

public class Interpreter {
    public static void main(String[] args) {

        TextMenu menu = new TextMenu();
        menu.addCommand(new ExitCommand("0", "exit"));

        IStmt ex1 = new CompStmt(new VarDeclStmt("v", new IntType()),
                new CompStmt(new AssignStmt("v", new ValueExp(new IntValue(2))), new PrintStmt(new VarExp("v"))));
        try{
            ex1.typecheck(new MyDict<String, IType>());
            PrgState state1 = new PrgState(ex1);
            IRepo repo1 = new Repo("log1.txt");
            repo1.addPrg(state1);
            Controller ctrl1 = new Controller(repo1);
            menu.addCommand(new RunExample("1", ex1.toString(), ctrl1));
        }catch (CustomException e){
            System.out.println(e);
        }

        IStmt ex2 = new CompStmt(new VarDeclStmt("a", new IntType()),
                new CompStmt(new VarDeclStmt("b", new IntType()),
                        new CompStmt(new AssignStmt("a", new ArithExp('+', new ValueExp(new IntValue(2)), new ArithExp('*', new ValueExp(new IntValue(3)), new ValueExp(new IntValue(5))))),
                                new CompStmt(new AssignStmt("b", new ArithExp('+', new VarExp("a"), new ValueExp(new IntValue(1)))), new PrintStmt(new VarExp("b"))))));
        try{
            ex2.typecheck(new MyDict<String, IType>());
            PrgState state2 = new PrgState(ex2);
            IRepo repo2 = new Repo("log2.txt");
            repo2.addPrg(state2);
            Controller ctrl2 = new Controller(repo2);
            menu.addCommand(new RunExample("2", ex2.toString(), ctrl2));
        }catch (CustomException e){
            System.out.println(e);
        }

        IStmt ex3 = new CompStmt(new VarDeclStmt("a", new BoolType()),
                new CompStmt(new VarDeclStmt("v", new IntType()),
                        new CompStmt(new AssignStmt("a", new ValueExp(new BoolValue(true))),
                                new CompStmt(new IfStmt(new VarExp("a"), new AssignStmt("v", new ValueExp(new IntValue(2))), new AssignStmt("v", new ValueExp(new IntValue(3)))), new PrintStmt(new
                                        VarExp("v"))))));
        try{
            ex3.typecheck(new MyDict<String, IType>());
            PrgState state3 = new PrgState(ex3);
            IRepo repo3 = new Repo("log3.txt");
            repo3.addPrg(state3);
            Controller ctrl3 = new Controller(repo3);
            menu.addCommand(new RunExample("3", ex3.toString(), ctrl3));
        }catch (CustomException e){
            System.out.println(e);
        }

        IStmt ex4 = new CompStmt(new VarDeclStmt("varf",new StringType()),new CompStmt(
                new AssignStmt("varf",new ValueExp(new StringValue("test.in"))),new CompStmt(
                new OpenRFileStmt(new VarExp("varf")),new CompStmt(
                new VarDeclStmt("varc",new IntType()),new CompStmt(
                new ReadFileStmt(new VarExp("varf"),"varc"),new CompStmt(
                new PrintStmt(new VarExp("varc")),new CompStmt(
                new ReadFileStmt(new VarExp("varf"),"varc") ,new CompStmt(new PrintStmt(new VarExp("varc")),
                new CloseRFileStmt(new VarExp("varf"))))))))));

        try{
            ex4.typecheck(new MyDict<String, IType>());
            PrgState state4 = new PrgState(ex4);
            IRepo repo4 = new Repo("log4.txt");
            repo4.addPrg(state4);
            Controller ctrl4 = new Controller(repo4);
            menu.addCommand(new RunExample("4", ex4.toString(), ctrl4));
        }catch (CustomException e){
            System.out.println(e);
        }

        IStmt ex5 = new CompStmt(new CompStmt(
                new VarDeclStmt("v",new IntType()),
                new CompStmt(
                        new AssignStmt("v",new ValueExp(new IntValue(4))),
                        new WhileStmt(
                                new RelExp(">", new VarExp("v"), new ValueExp(new IntValue(0))),
                                new CompStmt(new PrintStmt(new VarExp("v")),
                                        new AssignStmt( "v",new ArithExp('-',new VarExp("v"),new ValueExp(new IntValue(1)))))))), new PrintStmt(new VarExp("v")));

        try{
            ex5.typecheck(new MyDict<String, IType>());
            PrgState state5 = new PrgState(ex5);
            IRepo repo5 = new Repo("log5.txt");
            repo5.addPrg(state5);
            Controller ctrl5 = new Controller(repo5);
            menu.addCommand(new RunExample("5", ex5.toString(), ctrl5));
        }catch (CustomException e){
            System.out.println(e);
        }

        IStmt ex6 = new CompStmt(
                new VarDeclStmt("v",new RefType(new IntType())),
                new CompStmt(
                        new NewStmt("v",new ValueExp(new IntValue(20))),
                        new CompStmt(
                                new VarDeclStmt("a",new RefType(new RefType(new  IntType()))), new CompStmt(
                                new NewStmt("a",new VarExp("v")),new CompStmt(
                                new PrintStmt(new VarExp("v")),
                                new PrintStmt(new VarExp("a")))))));

        try{
            ex6.typecheck(new MyDict<String, IType>());
            PrgState state6 = new PrgState(ex6);
            IRepo repo6 = new Repo("log6.txt");
            repo6.addPrg(state6);
            Controller ctrl6 = new Controller(repo6);
            menu.addCommand(new RunExample("6", ex6.toString(), ctrl6));
        }catch (CustomException e){
            System.out.println(e);
        }

        IStmt ex7 = new CompStmt(
                new VarDeclStmt("v",new RefType(new IntType())),
                new CompStmt(
                        new NewStmt("v",new ValueExp(new IntValue(20))),
                        new CompStmt(
                                new VarDeclStmt("a",new RefType(new RefType(new  IntType()))), new CompStmt(
                                new NewStmt("a",new VarExp("v")),new CompStmt(
                                new PrintStmt(new rHExp(new VarExp("v"))),
                                new PrintStmt(new ArithExp('+' , new rHExp(new rHExp( new VarExp("a"))),new ValueExp(new IntValue(5)))))))));

        try{
            ex7.typecheck(new MyDict<String, IType>());
            PrgState state7 = new PrgState(ex7);
            IRepo repo7 = new Repo("log7.txt");
            repo7.addPrg(state7);
            Controller ctrl7 = new Controller(repo7);
            menu.addCommand(new RunExample("7", ex7.toString(), ctrl7));
        }catch (CustomException e){
            System.out.println(e);
        }

        IStmt ex8 = new CompStmt(
                new VarDeclStmt("v",new RefType(new IntType())),
                new CompStmt(
                        new NewStmt("v",new ValueExp(new IntValue(20))),
                        new CompStmt(
                                new PrintStmt(new rHExp(new VarExp("v"))), new CompStmt(
                                new wHStmt("v",new ValueExp(new IntValue(30))),
                                new PrintStmt(new ArithExp('+' ,new rHExp(new VarExp("v")),new ValueExp(new IntValue(5))))))));

        try{
            ex8.typecheck(new MyDict<String, IType>());
            PrgState state8 = new PrgState(ex8);
            IRepo repo8 = new Repo("log8.txt");
            repo8.addPrg(state8);
            Controller ctrl8 = new Controller(repo8);
            menu.addCommand(new RunExample("8", ex8.toString(), ctrl8));
        }catch (CustomException e){
            System.out.println(e);
        }

        IStmt ex9 = new CompStmt(
                new VarDeclStmt("v",new RefType(new IntType())),
                new CompStmt(
                        new NewStmt("v",new ValueExp(new IntValue(20))),
                        new CompStmt(
                                new VarDeclStmt("a",new RefType(new RefType(new  IntType()))), new CompStmt(
                                new NewStmt("a",new VarExp("v")),new CompStmt(
                                new NewStmt("v",new ValueExp(new IntValue(30))),
                                new PrintStmt(new rHExp(new rHExp( new VarExp("a")))))))));

        try{
            ex9.typecheck(new MyDict<String, IType>());
            PrgState state9 = new PrgState(ex9);
            IRepo repo9 = new Repo("log9.txt");
            repo9.addPrg(state9);
            Controller ctrl9 = new Controller(repo9);
            menu.addCommand(new RunExample("9", ex9.toString(), ctrl9));
        }catch (CustomException e){
            System.out.println(e);
        }

        IStmt ex10 = new CompStmt(new VarDeclStmt("v", new IntType()),
                new CompStmt(new VarDeclStmt("a",new RefType(new IntType())),
                        new CompStmt(new AssignStmt("v",new ValueExp(new IntValue(10))),
                                new CompStmt(new NewStmt("a",new ValueExp(new IntValue(22))),
                                        new CompStmt(new ForkStmt(new CompStmt(new wHStmt("a", new ValueExp(new IntValue(30))),
                                                new CompStmt(new AssignStmt("v",new ValueExp(new IntValue(32))),
                                                        new CompStmt(new PrintStmt(new VarExp("v")),new PrintStmt(new rHExp(new VarExp("a"))))))),new CompStmt(new PrintStmt(new VarExp("v")),new PrintStmt(new rHExp(new VarExp("a"))))))
                        )));

        try{
            ex10.typecheck(new MyDict<String, IType>());
            PrgState state10 = new PrgState(ex10);
            IRepo repo10 = new Repo("log10.txt");
            repo10.addPrg(state10);
            Controller ctrl10 = new Controller(repo10);
            menu.addCommand(new RunExample("10", ex10.toString(), ctrl10));
        }catch (CustomException e){
            System.out.println(e);
        }

        menu.show();
    }
}
