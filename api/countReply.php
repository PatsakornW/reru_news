<?php 
 $db = mysqli_connect('localhost','root','','reru');
 if(!$db){
     echo "Connect Fail";
 }

  if(isset($_POST["news_id"]))
  {
      $news_id=$_POST["news_id"];
  }
  else return;

 $queryResult = $db ->query("SELECT count(*) as count FROM `reply` where news_id = '$news_id';");

 

 $result=array();

 while($fetchData=$queryResult->fetch_assoc()){
    $result [] = $fetchData;
 }

 echo json_encode($result);
?>