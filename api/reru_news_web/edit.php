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

    $sql = "SELECT * FROM news where status = 'Approval' ORDER BY news_title ASC";
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
    <link rel="stylesheet" href="all_news.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-gH2yIJqKdNHPEq0n4Mqa/HGKIhSkIHeL5AyhkYV8i59U5AR6csBvApHHNl/vI1Bx" crossorigin="anonymous">
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+Thai:wght@200&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css" integrity="sha512-KfkfwYDsLkIlwQp6LFnl8zNdLGxu9YAA1QvwINks4PhcElQSvqcyVLLD9aMhXd13uQjoXtEKNosOWaZqXgel0g==" crossorigin="anonymous" referrerpolicy="no-referrer" />
    
    <style>
        .container {
            max-width: 600px;
        }
        
        a {
            text-decoration: none;
        }
       
    </style>
</head>

<body style="font-family: Kanit;"  >

    <div class="menu">
            <div class="logo" >
            <img src="imgf/reru.png" alt="" width="100" height="100" style="vertical-align:middle">
            </div>
            <ul>
                <li><a href="index.php" style='color: #0080c0'>หน้าหลัก</a></li>
                <li><a href="index.php?logout='1'" style='color: #0080c0'>ออกจากระบบ</a></li>
            </ul>
        </div>

    <div class="modal fade" id="userModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true"></div>
    
    <div class="container mt-5">
        <center><h1 style='color: #0053a6'>แก้ไขข้อมูล</h1></center>
        <hr>
        <form action="edit.php" method="post" >
            <!-- enctype="multipart/from-data" -->

            <div class="mb-3">
                <label for="idx" class="col-form-label">ID :</label> 
                <input type="text" readonly value="<?php echo $result['news_id']; ?>" disabled  class="form-control" name="idx" >
                <input type="hidden" value="<?php echo $result['news_id']; ?>"  class="form-control" name="news_id" >
                <label for="news_title" class="col-form-label">หัวข้อข่าว:</label>
                <input type="text" value="<?php echo $result['news_title']; ?>"  class="form-control" name="news_title" >
                <input type="hidden" value="<?php echo $result['news_img']; ?>"  class="form-control" name="img2" >
            </div>
            <!-- <div class="mb-3">
                <label for="news_date" class="col-form-label">วันที่ :</label>
                <input type="date" value="<?php echo $result['news_date']; ?>"  class="form-control" name="news_date">
            </div> -->
            <div class="mb-3">
                <label for="username" class="col-form-label">เพิ่มข่าวโดย :</label>
                <input type="text" value="<?php echo $result['username']; ?>"  class="form-control" name="username" disabled>
            </div>
            <div class="mb-3">
                <label for="news_type" class="form-label">ประเภทข่าว :</label>
                <select  name="news_type" class="form-select">
                <option value="ข่าวมหาวิทยาลัย" <?php if ($result["news_type"] == 'ข่าวมหาวิทยาลัย') {echo "selected";}?>>ข่าวมหาวิทยาลัย</option>
                <option value="ข่าวคณะ"<?php if ($result["news_type"] == 'ข่าวคณะ') {echo "selected";}?>>ข่าวคณะ</option>
                <option value="กิจกรรมหลัก"<?php if ($result["news_type"] == 'กิจกรรมหลัก') {echo "selected";}?>>กิจกรรมหลัก</option>
                <option value="กิจกรรมเลือก"<?php if ($result["news_type"] == 'กิจกรรมเลือก') {echo "selected";}?>>กิจกรรมเลือก</option>
                </select>
            </div>

            <div class="mb-3">
                <label for="status" class="form-label">สถานะ :</label>
                <select  name="status" class="form-select">
                <option value="Approve" <?php if ($result["status"] == 'Approve') {echo "selected";}?>>อนุมัติ</option>
                <option value="NotApprove" <?php if ($result["status"] == 'NotApprove') {echo "selected";}?>>ไม่อนุมัติ</option>
                </select>
            </div>

            <div class="mb-3">
                <label for="news_detail" class="col-form-label">รายละเอียดข่าว :</label>
                <input type="text   " value="<?php echo $result['news_detail']; ?>"  class="form-control" name="news_detail">
            </div>
            <div class="mb-3">
                    <label for="img" class="col-form-label">ภาพข่าว :</label>
                    <input type="file" class="form-control" id="imgInput" name="new_img">
                    <img width="100%" src="uploads/<?php echo $result['news_img']; ?>" id="previewImg" alt="">
                </div>

            <div class="modal-footer">
                <a class="btn btn-secondary" href="all_news.php" >Back</a>
                <button type="submit" name="update" value="update" class="btn btn-success">Update</button>
            </div>
            </form>
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