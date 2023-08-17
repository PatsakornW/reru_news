<?php
$db = mysqli_connect('localhost', 'root', '', 'reru');
if (!$db) {
    echo "Connect Fail";
}

if (isset($_POST["news_id"])) {
    $news_id = $_POST["news_id"];
} else return;

$queryResult = $db->query("SELECT * FROM reply 
 join user on user.uid = reply.uid  
 left join news on news.news_id = reply.news_id
 where reply.news_id = '$news_id' order by reply.date;");
//  $queryResult = $db ->query("SELECT * FROM reply  join user on user.uid = reply.uid
//  left join news on news.uid = reply.uid WHERE reply.news_id = '$news_id' GROUP BY reply.text ");


$result = array();

while ($fetchData = $queryResult->fetch_assoc()) {
    $result[] = $fetchData;
}

echo json_encode($result);
