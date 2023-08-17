<?php
session_start();
include('server.php') ?>


<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Kanit">
    <title>Register</title>
    <link rel="stylesheet" href="style.css">
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+Thai:wght@200&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css" integrity="sha512-KfkfwYDsLkIlwQp6LFnl8zNdLGxu9YAA1QvwINks4PhcElQSvqcyVLLD9aMhXd13uQjoXtEKNosOWaZqXgel0g==" crossorigin="anonymous" referrerpolicy="no-referrer" />
    <!-- <style>
        body {
            content: "";
    position: relative;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background-image: url('https://scontent.fnak2-1.fna.fbcdn.net/v/t39.30808-6/296483338_3418066541754857_3743684142149907978_n.jpg?_nc_cat=106&ccb=1-7&_nc_sid=0debeb&_nc_eui2=AeHcBi6sV-s5-yQSgNakmdBCHUYIB2FnQuIdRggHYWdC4ixihZ6p2CLix1zvGrWLMGktUcXST5t2I4H8Sgv4Rm7E&_nc_ohc=eGzICF9JGwsAX-GBNox&_nc_ht=scontent.fnak2-1.fna&oh=00_AfCWU40Jmbb0kWHb5Z4AzIjbIbln_fdqxCHIoalhxQV7uw&oe=6363E772');
    z-index: -1;

    background-position: center;
        }
    </style> -->
</head>

<body style="font-family: Kanit;">
    <div class="header ">
        <h2>ลงทะเบียน</h2>
    </div>

    <form action="register_db.php" method="post">
        <?php include('errors.php'); ?>
        <div class="input-group">
            <label for="username">ชื่อผู้ใช้</label>
            <input type="text" name="username">
        </div>
        <div class="input-group">
            <label for="email">อีเมล</label>
            <input type="email" name="email">
        </div>
        <div class="input-group">
            <label for="password_1">รหัสผ่าน</label>
            <input type="password" name="password_1">
        </div>
        <div class="input-group">
            <label for="password_2">ยืนยันรหัสผ่าน</label>
            <input type="password" name="password_2">
        </div>
        <div class="input-group">
            <button type="submit" name="reg_user" class="btn">ลงทะเบียน</button>
        </div>
        <p>พร้อมที่จะเป็นแอดมิน? <a href="login.php">เข้าสู่ระบบ</a></p>
    </form>
</body>

</html>