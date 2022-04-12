<?php
include '../database-connection.php';

global $conn;

session_start();


$userId = $_SESSION["id"];

$type = $_GET["type"];
$severity = $_GET["severity"];

if ($type == "")
    $query = "SELECT * FROM logbook WHERE user = '$userId'
            AND severity = '$severity'";
elseif ($severity == "")
    $query = "SELECT * FROM logbook WHERE user = '$userId'
            AND type = '$type'";
else
    $query = "SELECT * FROM logbook WHERE user = '$userId'
                AND type = '$type' AND severity = '$severity'";

$queryResult = $conn->query($query);

$logs = array();

while ($row = mysqli_fetch_array($queryResult)) {
    $log = array();
    array_push($log, $row["type"]);
    array_push($log, $row["severity"]);
    array_push($log, $row["date"]);
    array_push($log, $row["message"]);

    array_push($logs, $log);
}

echo json_encode($logs);

$conn->close();

?>