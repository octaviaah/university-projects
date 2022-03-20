package main;

import javafx.application.Application;
import javafx.fxml.FXMLLoader;
import javafx.scene.Parent;
import javafx.scene.Scene;
import javafx.stage.Stage;
import main.selectWindowController;

import java.io.IOException;

public class Main extends Application {
    public static void main(String[] args){
        launch(args);
    }

    @Override
    public void start(Stage primaryStage) throws IOException{
        FXMLLoader mainLoader = new FXMLLoader();
        mainLoader.setLocation(getClass().getResource("/main/mainWindow.fxml"));
        Parent mainWindow = mainLoader.load();
        mainWindowController mainWindowController = mainLoader.getController();

        primaryStage.setTitle("Main Window");
        primaryStage.setScene(new Scene(mainWindow, 936, 600));
        primaryStage.show();

        FXMLLoader selectLoader = new FXMLLoader();
        selectLoader.setLocation(getClass().getResource("/main/selectWindow.fxml"));
        Parent selectWindow = selectLoader.load();
        selectWindowController selectWindowController = selectLoader.getController();
        selectWindowController.setMainWindowController(mainWindowController);

        Stage selectStage = new Stage();
        selectStage.setTitle("Select Window");
        selectStage.setScene(new Scene(selectWindow, 900, 400));
        selectStage.show();
    }
}
