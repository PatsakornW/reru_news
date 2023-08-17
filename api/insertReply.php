<?php
    $db = mysqli_connect('localhost','root','','reru');

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

     if(isset($_POST["text"]))
     {
         $text=$_POST["text"];
     }
     else return;



     $q = "INSERT INTO reply (uid,news_id,text)VALUES ('$uid','$news_id','$text')";
     

     $arr=[];
     $exe=mysqli_query($db,$q);

     
     if($exe){
         $q2 = "UPDATE news SET total_comment = total_comment + 1 WHERE news_id = $news_id";
         $exe2=mysqli_query($db,$q2);
         $arr["Success"] ='True';
     }
     else $arr["Success"] ='False';

     print(json_encode($arr));


    
?>