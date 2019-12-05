package sample;

import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.fxml.FXMLLoader;
import javafx.scene.Parent;
import javafx.scene.Scene;
import javafx.scene.control.Button;
import javafx.scene.control.ChoiceBox;
import javafx.scene.control.Label;
import javafx.scene.control.TextField;
import javafx.stage.Stage;

import java.io.IOException;

public class Screen1LoginInvalidController {

    @FXML
    private Button retryButton;

    public void retry(ActionEvent event) throws IOException {

        Stage stage = null;
        Parent myNewscene = null;

        stage = (Stage) retryButton.getScene().getWindow();
        myNewscene = FXMLLoader.load(getClass().getResource("screen1.fxml"));

        Scene scene = new Scene(myNewscene);
        stage.setScene(scene);
        stage.setTitle("Atlantic Movie");
        stage.show();

    }


}
