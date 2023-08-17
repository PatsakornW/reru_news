<?php 
 $db = mysqli_connect('localhost','root','','reru');
 if(!$db){
     echo "Connect Fail";
 }
 
 //$queryResult = $db ->query("SELECT * FROM news");
 $queryResult = $db ->query("SELECT * FROM news JOIN user ON news.uid=user.uid 
 WHERE status like 'Approve' AND total_like > 50 limit 5");
 
  
 $result=array();

 while($fetchData=$queryResult->fetch_assoc()){
    $result [] = $fetchData;
 }

 echo json_encode($result);
?>