<?php
require_once('server.php');
session_start();

    if (!isset($_SESSION['username'])) {
        $_SESSION['msg'] = "You must log in first";
        header('location: login.php');
    }

    if (isset($_GET['logout'])) {
        session_destroy();
        unset($_SESSION['username']);
        header('location: login.php');
    }
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Kanit">
    <title>RERUNEWS</title>
    <!-- <link rel="stylesheet" href="style.css"> -->
    <link rel="stylesheet" href="index.css">
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+Thai:wght@200&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css" integrity="sha512-KfkfwYDsLkIlwQp6LFnl8zNdLGxu9YAA1QvwINks4PhcElQSvqcyVLLD9aMhXd13uQjoXtEKNosOWaZqXgel0g==" crossorigin="anonymous" referrerpolicy="no-referrer" />
</head>
<body style="font-family: Kanit;">

    <div class="container bg">
        <!--  notification message -->
        <?php if (isset($_SESSION['success'])) : ?>
            <div class="success">
                <h3>
                    <?php 
                        echo $_SESSION['success'];
                        unset($_SESSION['success']);
                    ?>
                </h3>
            </div>
        <?php endif ?>
    
        <!-- logged in user information
        <?php if (isset($_SESSION['username'])) : ?>
            <p>Welcome <strong><?php echo $_SESSION['username']; ?></strong></p>
        <?php endif ?> -->
        <div class="menu">
            <div class="logo" >
            <img src="imgf/reru.png" alt="" width="100" height="100" style="vertical-align:middle">
            </div>
            <ul>
                <li><a href="index.php"style='color: #F0FFFF' >หน้าหลัก</a></li>
                <li><a href="index.php?logout='1'" style='color: #F0FFFF'>ออกจากระบบ</a></li>
            </ul>
        </div>
        <div class="content">
            <div class="header" style='color: #F0FFFF'>
                <h2>Roi Et </h2>
                <h1>RAJABHAT</h1>
                <h1>UNIVERSITY</h1>
                <p>เว็บข่าวสารและกิจกรรมของมหาวิทยาลัยราชภัฏร้อยเอ็ด สำหรับแอดมินของมหาวิทยาลัยราชภัฏร้อยเอ็ดเท่านั้น</p>
            </div>

            <div class="grid-card">
                <a href="all_news.php"><div class="box bg1">
                    
                </div></a>
                <a href="approve.php"><div class="box bg2">
                    
                </div></a>
            </div>

        </div>

    </div>
</body>
</html>