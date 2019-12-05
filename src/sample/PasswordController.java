package sample;

import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.fxml.FXMLLoader;
import javafx.scene.Parent;
import javafx.scene.Scene;
import javafx.scene.control.Button;
import javafx.stage.Stage;

import java.io.IOException;

public class PasswordController {
    @FXML
    private Button retry;

    public void retry(ActionEvent event) throws IOException {
        Stage stage = (Stage) retry.getScene().getWindow();
        stage.close();

    }
}
