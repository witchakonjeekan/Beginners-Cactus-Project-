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
            $name_shop = $_GET['Name_Shop'];		
            $image_shop = $_GET['Image_Shop'];
            $detail_shop = $_GET['Detail'];
            $id_card = $_GET['ID_card'];
            $id_user = $_GET['ID'];
            $username = $_GET['Username'];
            
                                
            $sql = "INSERT INTO shop(Name_Shop,Image_Shop,Detail,ID_card,ID,Status,Username) VALUES ('$name_shop','$image_shop','$detail_shop','$id_card','$id_user','Shop','$username')";
    
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