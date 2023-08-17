<?php 
 $db = mysqli_connect('localhost','root','','reru');
 if(!$db){
     echo "Connect Fail";
 }
 if (isset($_POST["uid"])) {
    $uid = $_POST["uid"];
} else return;


 //$queryResult = $db ->query("SELECT * FROM news");
 $queryResult = $db ->query("SELECT * FROM news JOIN user ON news.uid=user.uid 
 WHERE status like 'NotApprove' and news.uid = '$uid' ");
 
  
 $result=array();

 while($fetchData=$queryResult->fetch_assoc()){
    $result [] = $fetchData;
 }

 echo json_encode($result);
?>