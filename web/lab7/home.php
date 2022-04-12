<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Home</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Work+Sans&display=swap" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="/lab7/style.css">
</head>
<body>
<h1 class="main-title">Welcome,
    <?php include 'database-connection.php';
    global $conn;
    session_start();
    $username = $_SESSION['username'];
    echo $username ?>!</h1>
<main class="container">
    <form class="center-form" autocomplete="off" action="actions/add-log.php" method="post"><!--add log-->
        <label class="boxes-home">
            <input class="box-input" type="text" name="type" placeholder="Enter type of log" required>
            <br>
            <input class="box-input" type="text" name="severity" placeholder="Enter severity of log" required>
            <br>
            <input class="box-input" type="text" name="date" placeholder="Enter date (yyyy-mm-dd)" required>
            <br>
            <input class="box-input" type="text" name="message" placeholder="Enter message for log" required>
        </label>
        <button class="button" type="submit">Add log</button>
    </form>
    <form class="center-form" action="actions/delete-log.php" method="post"><!--delete log-->
        <label class="boxes-home">
            <select name="id" class="box-input">
                <?php
                include 'database-connection.php';
                global $conn;
                $userId = $_SESSION["id"];
                $resultSet = $conn->query("SELECT * FROM `logbook` WHERE user = '$userId'");
                while ($rows = $resultSet->fetch_assoc()) {
                    $id = $rows['id'];
                    echo "<option value = '$id'>$id</option>";
                }
                ?>
            </select>
        </label>
        <button class="button" type="submit">Delete log</button>
    </form>
    <div>
        <input class="button" type="button" onclick="location.href='/lab7/actions/browse.php'" value="Browse all logs">
        <br>
        <input class="button" type="button" onclick="location.href='/lab7/actions/browse-user.php'" value="Browse your own logs">
    </div>
    <input class="button" type="button" onclick="location.href='../filter-page.html'" value="Filter Logs">
</main>
</body>
</html>