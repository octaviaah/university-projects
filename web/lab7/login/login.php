<?php

include '../database-connection.php';

global $conn;

session_start(); // set a custom session for the user


if ($_SERVER['REQUEST_METHOD']=='POST') { // if the login is found in the post array (from a login request)
    $username = $_POST['username'];
    $password = $_POST['password'];
    $selectQuery = "SELECT * FROM users WHERE username='$username' AND password='$password' LIMIT 1";
    $selectResult = $conn->query($selectQuery);
    if ($selectResult) {

        $selectUserResult = mysqli_fetch_row($selectResult);
        if ($selectUserResult == null){
            echo '<script>alert("Login failed");
                        location.href="../login/login.html"</script>';
        }
        else {
            $idFromDatabase = $selectUserResult[0];
            $usernameFromDatabase = $selectUserResult[1];  // storing the username

            if ($username == $usernameFromDatabase) {  // we find a match in the database
                $_SESSION['username'] = $username;
                $_SESSION['password'] = $password;
                $_SESSION['id'] = $idFromDatabase;
                header('Location: ../home.php');
            }
        }
    }
}
