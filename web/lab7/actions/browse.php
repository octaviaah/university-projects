<!DOCTYPE html>
<html>
<head>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.min.js" integrity="sha256-VazP97ZCwtekAsvgPBSUwPFKdrwD3unUfSGVYrahUqU=" crossorigin="anonymous"></script>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Work+Sans&display=swap" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="/lab7/style.css">
    <title>All logs</title>
</head>
<body>
<h1 class="main-title">All logs</h1>

<?php

if (isset($_GET['pageno'])) {
    $pageno = $_GET['pageno'];
} else {
    $pageno = 1;
}

include '../database-connection.php';

global $conn;

session_start();

$userId = $_SESSION["id"];

$no_of_records_per_page = 4;
$offset = ($pageno-1) * $no_of_records_per_page;

$total_pages_sql = "SELECT COUNT(*) FROM logbook";

//total rows and pages for browse all
$res = $conn->query($total_pages_sql);
$total_rows = mysqli_fetch_array($res)[0];
$total_pages = ceil($total_rows / $no_of_records_per_page);

$query = "SELECT * FROM logbook INNER JOIN users ON logbook.user = users.id LIMIT " .$offset .', '. $no_of_records_per_page . ';';
$result_set = $conn->query($query);


if(mysqli_num_rows($result_set)>0){
    echo "<table class='table-browse table'>";
    echo "<thead>";
    echo "<th>ID</th>";
    echo "<th>Author</th>";
    echo "<th>Message</th>";
    echo "<th>Type</th>";
    echo "<th>Severity</th>";
    echo "<th>Date Posted</th>";
    echo "</thead>";
    echo "<tbody>";
    while ($row = mysqli_fetch_array($result_set)){
        echo "<tr>";
        echo "<td>".$row['0']."</td>";
        echo "<td>".$row['username']."</td>";
        echo "<td>".$row['message']."</td>";
        echo "<td>".$row['type']."</td>";
        echo "<td>".$row['severity']."</td>";
        echo "<td>".$row['date']."</td>";
        echo "</tr>";
    }
    echo "</tbody>";
    echo "</table>";

}
$conn->close();
?>
<br>
<div class="container-browse">
    <button class="button">
        <a href="?pageno=1">First</a>
    </button>&emsp;
    <button class="button"<?php if($pageno <= 1){ echo 'disabled'; } ?>">
        <a href="<?php if($pageno <= 1){ echo '#'; } else { echo "?pageno=".($pageno - 1); } ?>">Prev</a>
    </button>&emsp;
    <button class="button"<?php if($pageno >= $total_pages){ echo 'disabled'; } ?>">
        <a href="<?php if($pageno >= $total_pages){ echo '#'; } else { echo "?pageno=".($pageno + 1); } ?>">Next</a>
    </button>&emsp;
    <button class="button">
        <a href="?pageno=<?php echo $total_pages; ?>">Last</a>
    </button>&emsp;
</div>
</body>
</html>