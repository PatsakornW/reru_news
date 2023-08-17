<!-- // $con = mysqli_connect('localhost','root','','reru_news');
//     if(!$con){
//         echo "Connect Fail";
//     }
//  $con= mysqli_connect("localhost","root","","reru_news") or die("Error: " . mysqli_error($con));
//  mysqli_query($con, "SET NAMES 'utf8' ");  -->


<?php 

    $servername = "localhost";
    $username = "root";
    $password = "";
    $dbname = "reru";

    // Create Connection
    $conn = mysqli_connect($servername, $username, $password, $dbname);

    // Check connection
    if (!$conn) {
        die("Connection failed" . mysqli_connect_error());
    } 

?>