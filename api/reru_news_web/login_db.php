<?php 
session_start();
include('server.php');

$errors = array();

if (isset($_POST['login_user'])) {
    $username = mysqli_real_escape_string($conn, $_POST['username']);
    $password = mysqli_real_escape_string($conn, $_POST['password']);

    if (empty($username)) {
        array_push($errors, "Username is required");
    }

    if (empty($password)) {
        array_push($errors, "Password is required");
    }

     if (count($errors) == 0) {
         $password = ($password);
         $query = "SELECT * FROM user WHERE username = '$username' AND password = '".$password."' ";
         $result = mysqli_query($conn, $query);

         if (mysqli_num_rows($result) == 1) {

            $test = mysqli_fetch_assoc($result);
             $_SESSION['uid'] = $test['uid'];
             //$_SESSION['uid'] = $uid;
             $_SESSION['username'] = $username;
             

             // $_SESSION['success'] = "Your are now logged in";
             header("location: index.php");
         } else {
             array_push($errors, "ชื่อผู้ใช้ หรือ รหัสผ่าน ไม่ถูกต้อง");
             $_SESSION['error'] = "ชื่อผู้ใช้ หรือ รหัสผ่าน ไม่ถูกต้อง!";
             header("location: login.php");
         }
     } else {
         array_push($errors, "ระบุชื่อผู้ใช้และรหัสผ่าน");
         $_SESSION['error'] = "ระบุชื่อผู้ใช้และรหัสผ่าน";
         header("location: login.php");
     }
}

?>