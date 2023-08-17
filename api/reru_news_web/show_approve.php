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

    
    $num = 1;

    $sql = "SELECT * FROM news where status = 'NotApprove' ORDER BY news_title ASC";
    
    $query = mysqli_query($conn,$sql);

    if (isset($_GET['delete'])) {
        $delete_id = $_GET['delete'];
        $deletestmt = $conn->query("DELETE FROM news WHERE news_id = $delete_id");

        if ($deletestmt) {
            echo "<script>alert('Data has been deleted successfully');</script>";
            $_SESSION['success'] = "Data has been deleted succesfully";
            header("refresh:1; url=all_news.php");
        }

    }

     if(isset($_GET["id"])) {
     $id = $_GET["id"];
     $sql = "SELECT * FROM news join user on user.uid = news.uid WHERE news_id = '".$id."'";
     $query = mysqli_query($conn,$sql);
     $result = mysqli_fetch_array($query,MYSQLI_ASSOC);
     }

    
    
     if (isset($_POST["update"])) {
         $id = $_POST["news_id"];
         echo $_POST["status"];
        

     $sql_2 = "UPDATE news SET 
         news_title = '".$_POST['news_title']
     ."', news_detail = '".$_POST['news_detail']
     // ."', news_date = '".$_POST['news_date']
     ."', status = '".$_POST['status']
     // ."', news_img = '".$_FILES['news_img']
     ."', news_type = '".$_POST['news_type']
     ."' WHERE news_id = '".$id."'";
     echo $sql_2;
     // die();
     $query_2 = mysqli_query($conn,$sql_2);
     header("location:all_news.php?update=pass");
     exit();
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
    <link rel="stylesheet" href="show.css">
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+Thai:wght@200&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css" integrity="sha512-KfkfwYDsLkIlwQp6LFnl8zNdLGxu9YAA1QvwINks4PhcElQSvqcyVLLD9aMhXd13uQjoXtEKNosOWaZqXgel0g==" crossorigin="anonymous" referrerpolicy="no-referrer" />


    <style>
        .teaser {
            background-color: whitesmoke;
            width: 900px;
            padding: 25px;
            border-radius: 25px;
            /* border: 2px solid #0080ff; */
            /* height: 600px;     */
            /* display: flex;
            position: relative; */
    
        }

        .mb-3 {
            text-align: start;
        }
    </style>

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

        <center><div class="teaser">
        <center><h3>รายละเอียดข่าว</h3></center><br>
        <form action="edit.php" method="post" >
            <!-- enctype="multipart/from-data" -->

            <div class="mb-3">
                <label for="idx" class="col-form-label">ID :</label>
                <h> <?php echo $result['news_id']; ?> </h><br>

                <label for="news_title" class="col-form-label">หัวข้อข่าว :</label>
                <h> <?php echo $result['news_title']; ?> </h><br>

                <input type="hidden" value="<?php echo $result['news_img']; ?>"  class="form-control" name="img2" >

                <label for="news_date" class="col-form-label">วันที่ :</label>
                <h> <?php echo $result['news_date']; ?> </h><br>

                <label for="username" class="col-form-label">เพิ่มข่าวโดย :</label>
                <h> <?php echo $result['username']; ?> </h><br>

                <label for="news_type" class="form-label">ประเภทข่าว :</label>
                <h> <?php echo $result['news_type']; ?> </h><br>

                <label for="status" class="form-label">สถานะ :</label>
                <h> <?php echo $result['status']; ?> </h><br>

                <label for="news_detail" class="col-form-label">รายละเอียดข่าว :</label><br>
                <h> <?php echo $result['news_detail']; ?> </h><br><br>

                <center><label for="news_img" class="col-form-label">ภาพข่าว </label><br>
                <img class="rounded" width="50%" src="/reru/<?php echo $result['news_img']; ?>"></img></center>
                
            </div>


        </div></center> 

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0/dist/js/bootstrap.bundle.min.js" integrity="sha384-A3rJD856KowSb7dwlZdYEkO39Gagi7vIsF0jrRAoQmDKKtQBHUuLZ9AsSv4jD4Xa" crossorigin="anonymous"></script>
    <script>
        let imgInput = document.getElementById('imgInput');
        let previewImg = document.getElementById('previewImg');

        imgInput.onchange = evt => {
            const [file] = imgInput.files;
            if (file) {
                previewImg.src = URL.createObjectURL(file);
            }
        }
    </script>



</body>
</html>