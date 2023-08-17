<?php
require_once('server.php');
session_start();
$filePath = '../uploadimg';
isset( $_FILES['image']['tmp_name'] ) ? $image_tmp_name = $_FILES['image']['tmp_name'] : $image_tmp_name = "";
     isset( $_FILES['image']['name'] ) ? $image_name = $_FILES['image']['name'] : $image_name = "";
    if( !empty( $image_tmp_name ) && !empty( $image_name ) ) {
     
         if( move_uploaded_file($image_tmp_name, "../uploadimg/".$image_name) ) echo "อัปโหลดรูปภาพสำเร็จ";
     }

// echo $_FILES['image']['name'];
 $sql = "INSERT INTO news (news_title,uid,news_type,news_detail,news_img) 
          VALUES ('".$_POST["news_title"]."','".$_SESSION["uid"]."','".$_POST["news_type"]."','".$_POST["news_detail"]."','".'uploadimg/'.$image_name."')";
          $query = mysqli_query($conn,$sql);

           header("location:all_news.php?add=pass");
          exit();

         mysqli_close($conn);
?>