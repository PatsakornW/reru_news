<?php
 $db = mysqli_connect('localhost','root','','reru');
 if(!$db){
     echo "Connect Fail";
 }

 if(isset($_POST["uid"]))
 {
     $uid=$_POST["uid"];
 }
 else return;

 if(isset($_POST["news_id"]))
 {
     $news_id=$_POST["news_id"];
 }
 else return;

 $result = $db->query("SELECT * FROM likes WHERE uid = '$uid' AND news_id = '$news_id' ");
 $count = mysqli_num_rows($result);
 if ($count == 1){
    echo json_encode("ONE");
 } else {
    echo json_encode("ZERO");
 }

?>