package main;

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
import Exception.CustomException;
import Repository.IRepo;
import Repository.Repo;
import javafx.collections.FXCollections;
import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.fxml.Initializable;
import javafx.scene.control.Alert;
import javafx.scene.control.Button;
import javafx.scene.control.ListView;

import java.net.URL;
import java.util.ArrayList;
import java.util.List;
import java.util.ResourceBundle;

public class selectWindowController implements Initializable {
    @FXML
    private Button selectButton;
    @FXML
    private ListView<IStmt> selectItemListView;
    private mainWindowController mainWindowController;

    private mainWindowController getMainWindowController(){
        return this.mainWindowController;
    }

    public void setMainWindowController(mainWindowController mainWindowController){
        this.mainWindowController = mainWindowController;
    }

    @FXML
    private IStmt selectExample(ActionEvent actionEvent){
        return selectItemListView.getItems().get(selectItemListView.getSelectionModel().getSelectedIndex());
    }

    private List<IStmt> initializeExamples(){
        List<IStmt> list = new ArrayList<>();
        IStmt ex1 = new CompStmt(new VarDeclStmt("v", new IntType()),
                new CompStmt(new AssignStmt("v", new ValueExp(new IntValue(2))), new PrintStmt(new VarExp("v"))));

        IStmt ex2 = new CompStmt(new VarDeclStmt("a", new IntType()),
                new CompStmt(new VarDeclStmt("b", new IntType()),
                        new CompStmt(new AssignStmt("a", new ArithExp('+', new ValueExp(new IntValue(2)), new ArithExp('*', new ValueExp(new IntValue(3)), new ValueExp(new IntValue(5))))),
                                new CompStmt(new AssignStmt("b", new ArithExp('+', new VarExp("a"), new ValueExp(new IntValue(1)))), new PrintStmt(new VarExp("b"))))));

        IStmt ex3 = new CompStmt(new VarDeclStmt("a", new BoolType()),
                new CompStmt(new VarDeclStmt("v", new IntType()),
                        new CompStmt(new AssignStmt("a", new ValueExp(new BoolValue(true))),
                                new CompStmt(new IfStmt(new VarExp("a"), new AssignStmt("v", new ValueExp(new IntValue(2))), new AssignStmt("v", new ValueExp(new IntValue(3)))), new PrintStmt(new
                                        VarExp("v"))))));

        IStmt ex4 = new CompStmt(new VarDeclStmt("varf",new StringType()),new CompStmt(
                new AssignStmt("varf",new ValueExp(new StringValue("test.in"))),new CompStmt(
                new OpenRFileStmt(new VarExp("varf")),new CompStmt(
                new VarDeclStmt("varc",new IntType()),new CompStmt(
                new ReadFileStmt(new VarExp("varf"),"varc"),new CompStmt(
                new PrintStmt(new VarExp("varc")),new CompStmt(
                new ReadFileStmt(new VarExp("varf"),"varc") ,new CompStmt(new PrintStmt(new VarExp("varc")),
                new CloseRFileStmt(new VarExp("varf"))))))))));

        IStmt ex5 = new CompStmt(new CompStmt(
                new VarDeclStmt("v",new IntType()),
                new CompStmt(
                        new AssignStmt("v",new ValueExp(new IntValue(4))),
                        new WhileStmt(
                                new RelExp(">", new VarExp("v"), new ValueExp(new IntValue(0))),
                                new CompStmt(new PrintStmt(new VarExp("v")),
                                        new AssignStmt( "v",new ArithExp('-',new VarExp("v"),new ValueExp(new IntValue(1)))))))), new PrintStmt(new VarExp("v")));

        IStmt ex6 = new CompStmt(
                new VarDeclStmt("v",new RefType(new IntType())),
                new CompStmt(
                        new NewStmt("v",new ValueExp(new IntValue(20))),
                        new CompStmt(
                                new VarDeclStmt("a",new RefType(new RefType(new  IntType()))), new CompStmt(
                                new NewStmt("a",new VarExp("v")),new CompStmt(
                                new PrintStmt(new VarExp("v")),
                                new PrintStmt(new VarExp("a")))))));

        IStmt ex7 = new CompStmt(
                new VarDeclStmt("v",new RefType(new IntType())),
                new CompStmt(
                        new NewStmt("v",new ValueExp(new IntValue(20))),
                        new CompStmt(
                                new VarDeclStmt("a",new RefType(new RefType(new  IntType()))), new CompStmt(
                                new NewStmt("a",new VarExp("v")),new CompStmt(
                                new PrintStmt(new rHExp(new VarExp("v"))),
                                new PrintStmt(new ArithExp('+' , new rHExp(new rHExp( new VarExp("a"))),new ValueExp(new IntValue(5)))))))));

        IStmt ex8 = new CompStmt(
                new VarDeclStmt("v",new RefType(new IntType())),
                new CompStmt(
                        new NewStmt("v",new ValueExp(new IntValue(20))),
                        new CompStmt(
                                new PrintStmt(new rHExp(new VarExp("v"))), new CompStmt(
                                new wHStmt("v",new ValueExp(new IntValue(30))),
                                new PrintStmt(new ArithExp('+' ,new rHExp(new VarExp("v")),new ValueExp(new IntValue(5))))))));

        IStmt ex9 = new CompStmt(
                new VarDeclStmt("v",new RefType(new IntType())),
                new CompStmt(
                        new NewStmt("v",new ValueExp(new IntValue(20))),
                        new CompStmt(
                                new VarDeclStmt("a",new RefType(new RefType(new  IntType()))), new CompStmt(
                                new NewStmt("a",new VarExp("v")),new CompStmt(
                                new NewStmt("v",new ValueExp(new IntValue(30))),
                                new PrintStmt(new rHExp(new rHExp( new VarExp("a")))))))));

        IStmt ex10 = new CompStmt(new VarDeclStmt("v", new IntType()),
                new CompStmt(new VarDeclStmt("a",new RefType(new IntType())),
                        new CompStmt(new AssignStmt("v",new ValueExp(new IntValue(10))),
                                new CompStmt(new NewStmt("a",new ValueExp(new IntValue(22))),
                                        new CompStmt(new ForkStmt(new CompStmt(new wHStmt("a", new ValueExp(new IntValue(30))),
                                                new CompStmt(new AssignStmt("v",new ValueExp(new IntValue(32))),
                                                        new CompStmt(new PrintStmt(new VarExp("v")),new PrintStmt(new rHExp(new VarExp("a"))))))),new CompStmt(new PrintStmt(new VarExp("v")),new PrintStmt(new rHExp(new VarExp("a"))))))
                        )));

        IStmt ex11 = new CompStmt(new VarDeclStmt("v", new BoolType()),
                new CompStmt(new AssignStmt("v", new ValueExp(new IntValue(40))),
                        new PrintStmt(new VarExp("v"))));

        list.add(ex1);
        list.add(ex2);
        list.add(ex3);
        list.add(ex4);
        list.add(ex5);
        list.add(ex6);
        list.add(ex7);
        list.add(ex8);
        list.add(ex9);
        list.add(ex10);
        list.add(ex11);
        return list;
    }

    private void displayExamples(){
        List<IStmt> examples = initializeExamples();
        this.selectItemListView.setItems(FXCollections.observableArrayList(examples));
        this.selectItemListView.getSelectionModel().select(0);
        this.selectButton.setOnAction(actionEvent -> {
            int index = this.selectItemListView.getSelectionModel().getSelectedIndex();
            IStmt selectedPrg = this.selectItemListView.getItems().get(index);
            index ++;
            PrgState state = new PrgState(selectedPrg);
            IRepo repo = new Repo("log" + index + ".txt");
            Controller ctrl = new Controller(repo);
            ctrl.addProgram(state);
            try{
                selectedPrg.typecheck(new MyDict<String, IType>());
                this.mainWindowController.setCtrl(ctrl);
            } catch(CustomException e){
                Alert alert = new Alert(Alert.AlertType.NONE);
                alert.setAlertType(Alert.AlertType.ERROR);
                alert.setContentText(e.getMessage());
                alert.show();
            }
        });
    }

    @Override
    public void initialize(URL url, ResourceBundle resourceBundle){
        displayExamples();
    }
}
