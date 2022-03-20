package main;

import Controller.Controller;
import Model.PrgState;
import Model.adt.IStack;
import Model.stmt.IStmt;
import Model.value.IValue;
import Exception.CustomException;
import Model.value.StringValue;
import javafx.beans.property.SimpleIntegerProperty;
import javafx.beans.property.SimpleStringProperty;
import javafx.collections.FXCollections;
import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.fxml.Initializable;
import javafx.scene.control.*;
import javafx.util.Pair;

import java.net.URL;
import java.util.*;
import java.util.stream.Collectors;

public class mainWindowController implements Initializable {
    @FXML
    private ListView<String> exeStackView;
    @FXML
    private TableView<Map.Entry<String, IValue>> symTableView;
    @FXML
    private TableColumn<Map.Entry<String, IValue>, String> symTableNames;
    @FXML
    private TableColumn<Map.Entry<String, IValue>, String> symTableValues;
    @FXML
    private Label prgStatesCount;
    @FXML
    private Button execButton;
    @FXML
    private TableView<Map.Entry<Integer, IValue>> heapTableView;
    @FXML
    private TableColumn<Map.Entry<Integer, IValue>, Integer> heapTableAddr;
    @FXML
    private  TableColumn<Map.Entry<Integer, IValue>, String> heapTableValues;
    @FXML
    private ListView<String> outputView;
    @FXML
    private ListView<String> fileTableView;
    @FXML
    private ListView<Integer> prgIDView;
    private Controller ctrl;

    public Controller getCtrl(){
        return this.ctrl;
    }

    public void setCtrl(Controller ctrl){
        this.ctrl = ctrl;
        populatePrgStatesCount();
        populateIDView();
        execButton.setDisable(false);
    }

    @Override
    public void initialize(URL url, ResourceBundle resourceBundle){
        this.ctrl = null;
        heapTableAddr.setCellValueFactory(p -> new SimpleIntegerProperty(p.getValue().getKey()).asObject());
        heapTableValues.setCellValueFactory(p -> new SimpleStringProperty(p.getValue().getValue() + " "));
        symTableNames.setCellValueFactory(p -> new SimpleStringProperty(p.getValue().getKey() + " "));
        symTableValues.setCellValueFactory(p -> new SimpleStringProperty(p.getValue().getValue() + " "));
        prgIDView.setOnMouseClicked(mouseEvent -> changePrgStateHandler(getSelectedPrgState()));
        execButton.setDisable(true);
    }

    private void changePrgStateHandler(PrgState state){
        if (state == null) return;
        try{
            populatePrgStatesCount();
            populateIDView();
            populateHeapTableView(state);
            populateOutputView(state);
            populateFileTableView(state);
            populateExeStackView(state);
            populateSymTableView(state);
        }
        catch (CustomException e){
            Alert error = new Alert(Alert.AlertType.ERROR, e.getMessage());
            error.show();
        }
    }

    public void oneStepHandler(ActionEvent actionEvent){
        if (this.ctrl == null){
            Alert error = new Alert(Alert.AlertType.ERROR, "No program selected!");
            error.show();
            execButton.setDisable(true);
            return;
        }
        PrgState state = getSelectedPrgState();
        if (state != null && !state.isNotCompleted()){
            Alert error = new Alert(Alert.AlertType.ERROR, "There is nothing left to be executed!");
            error.show();
            return;
        }
        try{
            this.ctrl.oneStep();
            changePrgStateHandler(state);
            if (this.ctrl.getRepo().getPrgList().size() == 0)
                execButton.setDisable(true);
        } catch(Exception e){
            Alert error = new Alert(Alert.AlertType.ERROR, e.getMessage());
            error.show();
        }
    }

    private void populatePrgStatesCount(){
        this.prgStatesCount.setText("Number of program states is " + this.ctrl.getRepo().getPrgList().size());
    }

    private void populateHeapTableView(PrgState state){
        this.heapTableView.setItems(FXCollections.observableList(new ArrayList<>(state.getHeap().getContent().entrySet())));
        this.heapTableView.refresh();
    }

    private void populateOutputView(PrgState state){
        this.outputView.setItems(FXCollections.observableArrayList(state.getOut().getContent()));
    }

    private void populateFileTableView(PrgState state){
        Set<String> auxSet;
        auxSet = new HashSet<String>();
        for(StringValue key : state.getFileTable().getDict().keySet()){
            auxSet.add(key.getValue());
        }
        this.fileTableView.setItems(FXCollections.observableArrayList(auxSet));
    }

    private void populateIDView(){
        this.prgIDView.setItems(FXCollections.observableArrayList(this.ctrl.getRepo().getPrgList().stream().map(PrgState::getProgramId).collect(Collectors.toList())));
        this.prgIDView.refresh();
    }

    private void populateExeStackView(PrgState state){
        IStack<IStmt> stack = state.getExeStack();
        List<String> stackOutput = new ArrayList<>();
        for (IStmt stmt: stack.getContent())
            stackOutput.add(stmt.toString());
        Collections.reverse(stackOutput);
        this.exeStackView.setItems(FXCollections.observableArrayList(stackOutput));
    }

    private void populateSymTableView(PrgState state){
        this.symTableView.setItems(FXCollections.observableList(new ArrayList<>(state.getSymTable().getDict().entrySet())));
        this.symTableView.refresh();
    }

    private PrgState getSelectedPrgState(){
        if (this.prgIDView.getSelectionModel().getSelectedIndex() == -1)
            return null;
        int id = this.prgIDView.getSelectionModel().getSelectedItem();
        return this.ctrl.getRepo().getPrgID(id);
    }

}
