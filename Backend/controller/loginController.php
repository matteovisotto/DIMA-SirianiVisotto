<?php
if(!isset($_POST['email']) || empty($_POST['email']) || !isset($_POST['password']) || empty($_POST['password']) ) {
	echo '{"exception":"Invalid or missing parameters"}';
	exit();
}

$email = $_POST['email'];
$password = $_POST['password'];
$login = loginWithCredential($email, $password);

if($login == null){
	echo '{"exception":"Invalid credential"}';
	exit();
}
echo json_encode($login);