<?php

if(!isset($_POST['aToken']) || empty($_POST['aToken'])){
	echo '{"exception":"Missing Apple Token"}';
}

$client_secret = "eyJraWQiOiIyWEhINE1LRjVCIiwiYWxnIjoiRVMyNTYifQ.eyJpc3MiOiIyRkU3TVAyNFg4IiwiaWF0IjoxNjUxMTY1NDczLCJleHAiOjE2NjY3MTc0NzMsImF1ZCI6Imh0dHBzOi8vYXBwbGVpZC5hcHBsZS5jb20iLCJzdWIiOiJpdC5tYXR0ZW92aXNvdHRvLmFwdHJhY2tlciJ9.dZcPlJQUPFAAXvAWsPNX6VPEO9D2spyPLqiouskDh4vGkapd3_3HVrihR8bSGVQMrrPccJ5Ekr8PJyEMN0qsLQ";

$name = isset($_POST['givenName']) ? $_POST['givenName'] : "";
$surname = isset($_POST['familyName']) ? $_POST['familyName'] : "";

$ch = curl_init();

curl_setopt($ch, CURLOPT_URL,"https://appleid.apple.com/auth/token");
curl_setopt($ch, CURLOPT_POST, 1);
curl_setopt($ch, CURLOPT_POSTFIELDS,
            "client_id=it.matteovisotto.aptracker&client_secret=".$client_secret."&grant_type=authorization_code&code=".$_POST['aToken']);
curl_setopt($ch, CURLOPT_HTTPHEADER, array('Content-Type: application/x-www-form-urlencoded'));


// receive server response ...
curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);

$response = curl_exec ($ch);

curl_close ($ch);

$response_obj = json_decode($response);
if(isset($response_obj->id_token)){
	$idToken = $response_obj->id_token;
	$obj = json_decode(base64_decode(explode(".", $idToken)[1]));
	$login = loginWithEmail($obj->email);
	if($login == null){
    	$username = "";
    	if($name==""){
        	$name = explode("@",$obj->email)[0];
        	$username = $name;
        } else {
        	$username = $name.$surname;
        }
    	
    	$uId = registerUser($name, $surname, $username, $obj->email, generateToken(16));
    	if($uId == null){
        	echo '{"exception":"An error occurred while registring a new account"}';
        	exit();
        }
    	$login = loginWithEmail($obj->email);
    }
    echo json_encode($login);
	exit();
}

echo '{"exception":"Invalid response from Apple"}';

?>