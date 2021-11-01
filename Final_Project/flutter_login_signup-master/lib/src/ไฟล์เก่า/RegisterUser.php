
<?php

$db = mysqli_connect('localhost','root','','cactus_db');
if (!$db){
    echo "Database connection failed";
}

$username = $_POST['Username'];
$pass = $_POST['Password'];
$email = $_POST['Email'];
$image = $_FILES['Image_Profile']['name'];
$status = $_POST['Status'];  



//  $sql = "SELECT * FROM login WHERE username = '".$username."' AND Email = '".$Email."'  AND password ='".$password."'"; 
 $sql = "SELECT * FROM user"; 

 $result = mysqli_query($db,$sql);
 $data = mysqli_fetch_array($result);
// $count = mysqli_num_rows($result);

//image Path
$imagePath = 'ImageUser/'.$image;
$tmp_name = $_FILES['Image_Profile']['tmp_name'];
move_uploaded_file($tmp_name, $imagePath);

if ($data == 1){
    echo json_encode('Error');
}else{
    $insert = "INSERT INTO user(Username,Email,Password,Image_Profile,Status)VALUES('".$username."','".$email."','".$pass."','".$image."','".$status."')";
    $query = mysqli_query($db,$insert);

    if ($query) {
        echo json_encode('Succes');
        
    }
    // echo json_encode(['status'=>'succes','username'=>$image]);
}
?>

