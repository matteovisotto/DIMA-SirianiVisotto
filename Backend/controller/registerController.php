<?php
$requiredParam = array("name", "surname", "email", "password");

foreach ($requiredParam as $p) {
	if (!checkParam($p)) {
    	echo '{"exception":"Invalid or missing parameters"}';
    	exit();
    }
}

$name = $_POST['name'];
$surname = $_POST['surname'];
$email = $_POST['email'];
$password = $_POST['password'];
$username = strtolower($name.$surname);

$registration = registerUser($name, $surname, $username, $email, $password);

if($registration == null){
	echo '{"exception":"An error occured while registring the account"}';
    exit();
}

echo '{"success":"Registration completed"}';

function checkParam($paramName) {
	return isset($_POST[$paramName]) && !empty($_POST[$paramName]);
}

?>