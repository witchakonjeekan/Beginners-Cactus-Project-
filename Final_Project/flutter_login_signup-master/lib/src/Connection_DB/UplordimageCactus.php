<?php
    // $db = mysqli_connect('localhost','root','','final_db');
    // if (!$db){
    //     echo "Database connection faild";
    // }

    // $image = $_FILES['image']['name']; //name ไม่เกี่ยวกับ database
    // $subspecies = $_POST['subspecies'];
    // $main_species = $_POST['main_species'];
    // $detail = $_POST['detail'];
    // $price = $_POST['price'];
    

    // $imagePath = 'UploadImage/'.$image;
    // $tmp_name = $_FILES['image']['tmp_name'];

    // move_uploaded_file($tmp_name, $imagePath);

    // $db ->query("INSERT INTO detailshop(main_species,subspecies,image,detail,price)VALUES('แอสโตรไฟรตัม','".$subspecies."','".$image."','".$detail."','".$price."')");

    error_reporting(E_ERROR | E_PARSE);

    // Response object structure
    $response = new stdClass;
    $response->status = null;
    $response->message = null;
    
    // Uploading file
    $destination_dir = "ImageCactus/";
    $base_filename = basename($_FILES["file"]["name"]);
    $target_file = $destination_dir . $base_filename;
    
    if(!$_FILES["file"]["error"])
    {
        if (move_uploaded_file($_FILES["file"]["tmp_name"], $target_file)) {
            $response->status = true;
            $response->message = "File uploaded successfully";
    
        } else {
    
            $response->status = false;
            $response->message = "File uploading failed";
        }
    } 
    else
    {
        $response->status = false;
        $response->message = "File uploading failed";
    }
    
    header('Content-Type: application/json');
    echo json_encode($response);

?>


