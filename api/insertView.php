<?php
    $db = mysqli_connect('localhost','root','','reru');


     if(isset($_POST["news_id"]))
     {
         $news_id=$_POST["news_id"];
     }
     else return;



     $q = "UPDATE news SET total_view = total_view + 1 WHERE news_id = $news_id";
     

     $arr=[];
     $exe=mysqli_query($db,$q);

     
     if($exe){

         $arr["Success"] ='True';
     }
     else $arr["Success"] ='False';

     print(json_encode($arr));


    
?>