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
            //Manager_id	Spe_main	Spe_sup	Detail	Price	Image_cactus	Shop_id
            // $id_shop = $_GET['Shop_id'];
            $name_main = $_GET['Spe_main'];		
            $name_sup = $_GET['Spe_sup'];
            $detail_cactus = $_GET['Detail'];
            $price = $_GET['Price'];
            $image_cactus = $_GET['Image_cactus'];
            $id_shop = $_GET['Shop_id'];
            $shopname = $_GET['Shopname'];
                                
            $sql = "INSERT INTO detailcactus(Spe_main,Spe_sup,Detail,Price,Image_cactus,Shop_id,Shopname) 
            VALUES ('$name_main','$name_sup','$detail_cactus','$price','$image_cactus','$id_shop','$shopname')";
    
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