
<?php
include 'conn.php';

$sql = "CREATE TABLE videoData (
id INT(6) UNSIGNED AUTO_INCREMENT PRIMARY KEY,
title VARCHAR(30) NOT NULL,
singer VARCHAR(30) NOT NULL,
cat VARCHAR(30) NOT NULL,
video_url VARCHAR(50),
time TIMESTAMP
)";

if (mysqli_query($connect, $sql)) {
    echo "Table MyGuests created successfully";
} else {
   
}

?>