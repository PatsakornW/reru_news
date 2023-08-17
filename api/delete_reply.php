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

if(isset($_POST["reply_id"]))
{
    $reply=$_POST["reply_id"];
}
else return;

if(isset($_POST["uid"]))
{
    $uid=$_POST["uid"];
}
else return;

$arr = [];

$q =  "DELETE FROM reply WHERE reply_id = '$reply' AND uid = '$uid'";
$exe = mysqli_query($db,$q);


if($exe){
    mysqli_query($db,"UPDATE news SET total_comment = total_comment - 1 WHERE news_id = $news");
    //$exe2=mysqli_query($db,$q2);
    $arr["Success"]="True";
} else
{$arr["Success"]="Fail";}

print(json_encode($arr));


?>