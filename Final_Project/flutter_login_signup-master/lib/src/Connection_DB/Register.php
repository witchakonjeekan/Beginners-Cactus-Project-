<?php
header("content-type:text/javascript;charset=utf-8");
error_reporting(0);
error_reporting(E_ERROR | E_PARSE);
$link = mysqli_connect('localhost', 'root', '', "cactus_db");

if (!$link) {
    echo "Error: Unable to connect to MySQL." . PHP_EOL;
    echo "Debugging errno: " . mysqli_connect_errno() . PHP_EOL;
    echo "Debugging error: " . mysqli_connect_error() . PHP_EOL;

    exit;
}

if (!$link->set_charset("utf8")) {
    printf("Error loading character set utf8: %s\n", $link->error);
    exit();
    }

if (isset($_GET)) {
    if ($_GET['isAdd'] == 'true') {

        $Username = $_GET['Username'];
        $Email = $_GET['Email'];
        $Password = $_GET['Password'];
        $Image_Profile = $_GET['Image_Profile'];
        $Status = $_GET['Status'];

        $sql = "INSERT INTO user(Username, Email, Password, Image_Profile, Status) VALUES ('$Username', '$Email', '$Password', '$Image_Profile', '$Status')";

        $result = mysqli_query($link, $sql);

        if ($result) {
            echo "true";
        } else {
            echo "false";
        }

    } else echo "Welcome";

}
    mysqli_close($link);
?>