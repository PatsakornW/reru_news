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

    $sql = "SELECT * FROM news join user on user.uid = news.uid where news.status = 'NotApprove' ORDER BY news_title ASC ";
    $query = mysqli_query($conn,$sql);


    if (isset($_GET['delete'])) {
        $delete_id = $_GET['delete'];
        $deletestmt = $conn->query("DELETE FROM news WHERE news_id = $delete_id");

        if ($deletestmt) {
            echo "<script>alert('ลบข้อมูลเสร็จสิ้น');</script>";
            $_SESSION['success'] = "ลบข้อมูลเสร็จสิ้น";
            header("refresh:1; url=approve.php");
        }

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
    <link rel="stylesheet" href="all_news.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-gH2yIJqKdNHPEq0n4Mqa/HGKIhSkIHeL5AyhkYV8i59U5AR6csBvApHHNl/vI1Bx" crossorigin="anonymous">
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+Thai:wght@200&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css" integrity="sha512-KfkfwYDsLkIlwQp6LFnl8zNdLGxu9YAA1QvwINks4PhcElQSvqcyVLLD9aMhXd13uQjoXtEKNosOWaZqXgel0g==" crossorigin="anonymous" referrerpolicy="no-referrer" />
    <style>
        a {
            text-decoration: none;
        }

        body {
            background: #f2f5ff;
            /* background-filter: brightness(50%); */
        
        }

        th {
            text-align: center;
        }

        td{
            text-align: center;
        }
</style>
</head>

<body style="font-family: Kanit;">

    <div class="menu">
            <div class="logo" >
            <img src="imgf/reru.png" alt="" width="100" height="100" style="vertical-align:middle">
            </div>
            <ul>
                <li><a href="index.php" style='color: #0080c0'>หน้าหลัก</a></li>
                <li><a href="index.php?logout='1'" style='color: #0080c0'>ออกจากระบบ</a></li>
            </ul>
        </div>


    <div class="container mt-5">
        <div class="row">
            <div class="col-md-6">
                <center><h1>รออนุมัติ</h1></center>
            </div>
        
        </div>
        <hr>
        <?php if (isset($_SESSION['success'])) { ?>
            <div class="alert alert-success">
                <?php 
                echo $_SESSION['success'];
                unset($_SESSION['success']);
                ?>
            </div>
        <?php } ?>

        <?php if (isset($_SESSION['error'])) { ?>
            <div class="alert alert-danger">
                <?php 
                echo $_SESSION['error'];
                unset($_SESSION['error']);
                ?>
            </div>
        <?php } ?>

        <!-- news data -->
        <table class="table">
            <thead>
                <tr style='color: #0080c0'>
                    <th scope="col">ลำดับ</th>
                    <th scope="col"width="300px">หัวข้อ</th>
                    <th scope="col"width="200px">วันที่</th>
                    <th scope="col"width="100">เพิ่มข่าวโดย</th>
                    <th scope="col"width="200">ประเภท</th>
                    <!-- <th scope="col"width="450px">รายละเอียด</th>
                    <th scope="col"width="100px">รูปภาพ</th> -->
                    <th scope="col"width="75px">สถานะ</th>
                    <th scope="col"width="600px">ตัวเลือก</th>
                </tr>
            </thead>
            <tbody >
              <?php
              while ($result = mysqli_fetch_array($query)) {
                // print_r($result);
                // die();
                ?>
                <tr>
                  <th scope="row"><?php echo $num++; ?></th>
                  <td><?php echo $result['news_title']; ?></td>
                  <td><?php echo $result['news_date']; ?></td>
                  <td><?php echo $result['username']; ?></td>
                  <td><?php echo $result['news_type']; ?></td>
                  <!-- <td><?php echo $result['news_detail']; ?></td>
                  <td width="250px"><img class="rounded" width="100%" src="./<?php echo $result['news_img']; ?>" alt=""></td> -->
                  <td><?php echo $result['status']; ?></td>
                    <td>
                        <a href="show_approve.php?id=<?php echo $result['news_id']; ?>" class="btn btn-success">รายละเอียด</a>
                        <a href="edit.php?id=<?php echo $result['news_id']; ?>" class="btn btn-warning">แก้ไข</a>
                        <a onclick="return confirm('คุณต้องการที่จะลบข้อมูลใช่หรือไม่?');" href="?delete=<?php echo $result['news_id']; ?>" class="btn btn-danger">ลบ</a>
                    </td>
                </tr>

                
                <?php
              }
              ?>
            </tbody>
            </table>
    </div>
             
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

<?php mysqli_close($conn); ?>
</body>
</html>