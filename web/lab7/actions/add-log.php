<?php
include '../database-connection.php';

global $conn;

session_start();

function function_alert($message) {
    echo "<script>alert('$message');
                  location.href='../home.php';</script>";
}


if ($_SERVER["REQUEST_METHOD"] == "POST") {

    $stmt = $conn->prepare("INSERT INTO logbook(type, severity, date, user, message) VALUES (?, ?, ?, ?, ?)");
    $stmt->bind_param("sssis", $_POST['type'], $_POST['severity'], $_POST['date'], $_SESSION["id"], $_POST['message']);
    $stmt->execute();
    $stmt->close();
    /*
    $userId = $_SESSION["id"];

    $type = $_POST["type"];
    $severity = $_POST["severity"];
    $date = $_POST["date"];
    $message = $_POST["message"];

    $query = "INSERT INTO logbook(type, severity, date, user, message) VALUES ('$type','$severity', '$date', '$userId','$message')";
    $queryResult = $conn->query($query);

    // close the database connection
    $conn->close();*/

}

return function_alert("The log was added successfully!");

?>