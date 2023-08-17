<?php
    session_start();
    include('server.php'); 

?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet"href="https://fonts.googleapis.com/css?family=Kanit">
    <title>Login</title>

    <link rel="stylesheet" href="style.css">
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+Thai:wght@200&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css" integrity="sha512-KfkfwYDsLkIlwQp6LFnl8zNdLGxu9YAA1QvwINks4PhcElQSvqcyVLLD9aMhXd13uQjoXtEKNosOWaZqXgel0g==" crossorigin="anonymous" referrerpolicy="no-referrer" />
</head>
<body style="font-family: Kanit;">

<div class="container bg">

    <div class="header">
        <img src="imgf/reru.png" alt="" width="100" height="100" style="vertical-align:middle">
        <h2>RERU NEWS</h2>
    </div>

    <form action="login_db.php" method="post">
    <?php if (isset($_SESSION['error'])) : ?>
            <div class="error">
                <h3>
                    <?php 
                        echo $_SESSION['error'];
                        unset($_SESSION['error']);
                    ?>
                </h3>
            </div>
        <?php endif ?>
        <div class="input-group">
            <label for="username">ชื่อผู้ใช้</label>
            <input type="text" name="username">
        </div>
        <div class="input-group">
            <label for="password">รหัสผ่าน</label>
            <input type="password" name="password">
        </div>
        <div class="input-group">
            <center><button type="submit" name="login_user" class="btn">เข้าสู่ระบบ</button></center>
        </div>
        <center><p>ยังไม่ลงทะเบียน? <a href="register.php">ลงทะเบียน</a></p></center>
    </form>

</div>
</body>
</html>