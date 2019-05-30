<?php

include 'conn.php';

$videos = $_FILES['videos']['name'];
$thumbs = $_FILES['thumbs']['name'];

$videoPath = "uploads/".$videos;
$thumbPath = "uploads/thumbs/".$thumbs;

move_uploaded_file($_FILES['videos']['tmp_name'], $videoPath);
move_uploaded_file($_FILES['thumbs']['tmp_name'], $thumbPath);
?>