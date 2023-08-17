<?php
       $db = mysqli_connect('localhost','root','','reru');

    if(isset($_POST["text"])){
         $text=$_POST["text"];
    } else return;

    if(isset($_POST["reply_id"]))
     {
         $reply=$_POST["reply_id"];
     } else return;

    
     if(isset($_POST["uid"]))
     {
         $uid=$_POST["uid"];
     } else return;


     $q = "UPDATE reply SET text = '$text' WHERE reply_id = '$reply' and uid = '$uid'";
     $exe = mysqli_query($db,$q);
     $arr=[];
     if($exe){
        $arr["Success"] ='True';
     } else  $arr["Success"] ='fail';
     
     print(json_encode($arr));
     

?>