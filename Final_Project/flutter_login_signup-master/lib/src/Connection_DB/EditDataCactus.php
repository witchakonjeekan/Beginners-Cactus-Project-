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
			
		$id = $_GET['Manager_id'];
        $nameSup = $_GET['Spe_sup'];
        $detail = $_GET['Detail'];
        $price = $_GET['Price'];
        $pathimage = $_GET['Image_cactus'];

									
		$sql = "UPDATE `detailcactus` SET `Spe_sup`='$nameSup',`Detail`='$detail',`Price`='$price',`Image_cactus`='$pathimage' WHERE Manager_id = '$id'";

		$result = mysqli_query($link, $sql);

		if ($result) {
			echo "true";
		} else {
			echo "false";
		}

	} else echo "Welcome THE King";
   
}

	mysqli_close($link);
?>