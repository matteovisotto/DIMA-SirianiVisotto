<?php

if(!isset($_POST['gToken']) || empty($_POST['gToken'])){
	echo '{"exception":"Missing Google Token"}';
}

$CLIENT_ID = "69497537086-q9peoqc9d892p0ps5jv95fmut3h7v9dh.apps.googleusercontent.com";

$client = new Google_Client(['client_id' => $CLIENT_ID]);  // Specify the CLIENT_ID of the app that accesses the backend
$payload = $client->verifyIdToken($_POST['gToken']);
if ($payload) {
  $email = $payload['email'];
  $login = loginWithEmail($email);
	if($login == null){
    	$uId = registerUser($payload['given_name'], $payload['family_name'], $payload['given_name'].$payload['family_name'], $email, generateToken(16));
    	if($uId == null){
        	echo '{"exception":"An error occurred while registring a new account"}';
        	exit();
        }
    	$login = loginWithEmail($email);
    }
    echo json_encode($login);
} else {
  echo '{"exception":"Invalid Google Token"}';
}
?>