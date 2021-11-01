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
            $shopid = $_GET['Shop_id'];		
            $shopname = $_GET['Shop_name'];
            $token = $_GET['Token'];
            
                                
            $sql = "INSERT INTO `report`(Shop_id,Shop_name,report_send,Token) VALUES ('$shopid','$shopname','on','$token')";
    
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