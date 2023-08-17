<?php
     $db = mysqli_connect('localhost','root','','reru');
     $query="SELECT news_img FROM news";
     $exe=mysqli_query($db,$query);
     $arr=[];

     while($row=mysqli_fetch_array($exe))
     {
        $arr[]=$row;
     }
     print(json_encode($arr));
?>