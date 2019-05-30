<?php
include 'conn.php';

$title = $_POST['title'];
$singer = $_POST['singer'];
$cat = $_POST['cat'];
$videourl = $_POST['videourl'];
$thumburl = $_POST['thumburl'];

$connect->query("INSERT INTO videodata (title,singer,cat,video_url,thumb_url) VALUES ('".$title."','".$singer."','".$cat."','".$videourl."','".$thumburl."') ");

?>