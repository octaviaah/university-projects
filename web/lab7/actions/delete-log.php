<?php
include '../database-connection.php';

global $conn;

session_start();

function function_alert($message) {
    echo "<script>alert('$message');
                  location.href='../home.php';</script>";
}

if ($_SERVER["REQUEST_METHOD"] == "POST") {


    $stmt = $conn->prepare("DELETE FROM logbook WHERE id = ?");
    $stmt->bind_param("i", $_POST['id']);
    $stmt->execute();
    $stmt->close();
    /*
    $logId = $_POST["id"];

    $query = "DELETE FROM logbook WHERE id = '$logId'";
    $queryResult = $conn->query($query);

    // close the database connection
    $conn->close();*/
}

return function_alert("The log was deleted successfully!");

?>