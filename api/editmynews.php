<?php
       $db = mysqli_connect('localhost','root','','reru');

       if(isset($_POST["news_id"]))
       {
           $news=$_POST["news_id"];
       } else return;

    if(isset($_POST["news_title"])){
         $title=$_POST["news_title"];
    } else return;

    if(isset($_POST["news_detail"]))
     {
         $detail=$_POST["news_detail"];
     } else return;

    
     if(isset($_POST["news_type"]))
     {
         $type=$_POST["news_type"];
     } else return;

    
     if(isset($_POST["uid"]))
     {
         $uid=$_POST["uid"];
     } else return;

     if(isset($_POST["name"]))
     {
         $name=$_POST["name"];
     }
     else return;

     if(isset($_POST["data"]))
     {
         $data=$_POST["data"];
     }
     else return;

    $path="uploadimg/$name";

    

     $q = "UPDATE news SET news_title = '$title',news_detail = '$detail',news_type = '$type',news_img = '$path' WHERE news_id = '$news' and uid = '$uid'";
     file_put_contents($path,base64_decode($data));
     $exe = mysqli_query($db,$q);
     $arr=[];
     if($exe){
        $arr["Success"] ='True';
     } else  $arr["Success"] ='fail';
     
     print(json_encode($arr));
     

?>