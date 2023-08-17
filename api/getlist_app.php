<?php 
 $db = mysqli_connect('localhost','root','','reru');
 if(!$db){
     echo "Connect Fail";
 }
 
 //$queryResult = $db ->query("SELECT * FROM news");
 $queryResult = $db ->query("SELECT * FROM list");
 
  
 $result=array();

 while($fetchData=$queryResult->fetch_assoc()){
    $result [] = $fetchData;
 }

 echo json_encode($result);
?>