<?php
//  $db = mysqli_connect('localhost','root','','reru');
//  if(!$db){
//      echo "Connect Fail";
//  }

//  if(isset($_POST["uid"]))
//  {
//      $uid=$_POST["uid"];
//  }
//  else return;

//  if(isset($_POST["news_id"]))
//  {
//      $news_id=$_POST["news_id"];
//  }
//  else return;


//  $result = $db->query("SELECT * FROM likes WHERE uid = '$uid' AND news_id = '$news_id' ");
//  $count = mysqli_num_rows($result);
//  if ($count == 1){
//     $sql = $db->query("SELECT * FROM news WHERE news_id = '$news_id' ");
//     $data = mysqli_fetch_array($sql);
//     $sum = $data['total_like'] -1 ;
//     $db->query("UPDATE news SET total_like = '$sum' WHERE news_id = '$news_id' ");
//     //$db->query("DELETE FROM news WHERE uid = '$uid'AND news_id ='$news_id' ");

//  } else {
//     $sql = $db->query("SELECT * FROM news WHERE news_id = '$news_id' ");
//     $data = mysqli_fetch_array($sql);
//     $sum = $data['total_like'] +1 ;
//     $db->query("INSERT INTO likes (uid,news_id,islike) VALUES ('$uid','$news_id','1')");
//     $db->query("UPDATE news SET total_like = '$sum' WHERE news_id = '$news_id' ");
//  }

    $db = mysqli_connect('localhost','root','','reru');


     if(isset($_POST["news_id"]))
     {
         $news_id=$_POST["news_id"];
     }
     else return;



     $q = "UPDATE news SET total_like = total_like + 1 WHERE news_id = $news_id";
     

     $arr=[];
     $exe=mysqli_query($db,$q);

     
     if($exe){

         $arr["Success"] ='True';
     }
     else $arr["Success"] ='False';

     print(json_encode($arr));


    

?>
