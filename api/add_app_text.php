<?php
    $db = mysqli_connect('localhost','root','','reru');

    if(isset($_POST["news_title"]))
    {
        $title=$_POST["news_title"];
    }
    else return;

    if(isset($_POST["news_detail"]))
    {
        $detail=$_POST["news_detail"];
    }
    else return;

    if(isset($_POST["news_type"]))
    {
        $type=$_POST["news_type"];
    }
    else return;

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

    $query = "INSERT INTO news (news_title,news_detail,news_img,news_type) VALUES ('$title','$detail','$path','$type')";
    file_put_contents($path,base64_decode($data));

    $arr=[];
    $exe=mysqli_query($db,$query);
    if($exe){
        $arr["Success"]='True';
    }
    else $arr["Success"]='False';

    print(json_encode($arr));


?>