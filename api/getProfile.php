<?php
$db = mysqli_connect('localhost', 'root', '', 'reru');
if (!$db) {
    echo "Connect Fail";
}

if (isset($_POST["uid"])) {
    $uid = $_POST["uid"];
} else return;



$queryResult = $db->query("SELECT * FROM user 
 where uid = '$uid'");
//  $queryResult = $db ->query("SELECT * FROM reply  join user on user.uid = reply.uid
//  left join news on news.uid = reply.uid WHERE reply.news_id = '$news_id' GROUP BY reply.text ");


$result = array();

while ($fetchData = $queryResult->fetch_assoc()) {
    $result[] = $fetchData;
}

echo json_encode($result);
