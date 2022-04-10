<?php
if(!isset($_POST['refreshToken']) || empty($_POST['refreshToken'])){
	echo '{"exception": "Invalid or missing parameters"}';
	exit();
}
$userId = verifyRefreshToken($_POST['refreshToken']);
if($userId == null){
	echo '{"exception": "Invalid refresh token"}';
	exit();
}

$result = refreshToken($_POST['refreshToken'], $userId);
if($result == null){
	echo '{"exception": "An error occurred"}';
	exit();
}

echo json_encode($result);