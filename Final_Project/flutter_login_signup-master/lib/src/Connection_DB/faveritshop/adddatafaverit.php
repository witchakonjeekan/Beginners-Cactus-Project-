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
                    
            // $id_shop = $_GET['Shop_id'];
            $iduser = $_GET['ID_User'];		
            $tokenuser = $_GET['Token_User'];
            $idshop = $_GET['ID_Shop'];
            $nameshop = $_GET['Name_Shop'];
            $tokenshop = $_GET['Token_Shop'];
            
            
                                
            $sql = "INSERT INTO favorites(ID_User,Token_User,ID_Shop,Name_Shop,Token_Shop) VALUES ('$iduser','$tokenuser','$idshop','$nameshop','tokenshop')";
    
            $result = mysqli_query($link, $sql);
    
            if ($result) {
                echo "true";
            } else {
                echo "false";
            }
    
        } else echo "Welcome Jeekan";
       
    }
        mysqli_close($link);
?>