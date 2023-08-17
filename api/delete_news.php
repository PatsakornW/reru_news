<?php
$db = mysqli_connect('localhost','root','','reru');
if(!$db){
    echo "Connect Fail";
}

if(isset($_POST["news_id"]))
{
    $news=$_POST["news_id"];
}
else return;

if(isset($_POST["uid"]))
{
    $uid=$_POST["uid"];
}
else return;


$q = "DELETE FROM news WHERE news_id = '$news' AND uid = '$uid'";

$exe = mysqli_query($db,$q);
$arr = [];
if($exe){
    $arr["Success"]="True";
} else{$arr["Success"]="Fail";}

print(json_encode($arr));


?>