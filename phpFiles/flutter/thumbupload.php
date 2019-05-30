<?php

include 'conn.php';


$thumbs = $_FILES['thumbs']['name'];


$thumbPath = "uploads/thumbs/".$thumbs;


move_uploaded_file($_FILES['thumbs']['tmp_name'], $thumbPath);
?>