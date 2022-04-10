<?php
if(!isset($_POST["fbToken"]) || empty($_POST["fbToken"])){
	echo '{"exception":"Missing Facebook Token"}';
	exit();
}

$fbToken = $_POST["fbToken"];

$curlSES=curl_init(); 
curl_setopt($curlSES,CURLOPT_URL,"https://graph.facebook.com/me?fields=email,name&access_token=".$fbToken);
curl_setopt($curlSES,CURLOPT_RETURNTRANSFER,true);
curl_setopt($curlSES,CURLOPT_HEADER, false); 
$result=curl_exec($curlSES);
curl_close($curlSES);

$jsonResult = json_decode($result);
if(isset($jsonResult->error)){
	echo json_encode($jsonResult->error);
	exit();
}
$email = $jsonResult->email;

$login = loginWithEmail($email);
	if($login == null){
    	$totName = $jsonResult->name;
		$username = strtolower(str_replace(" ", "", $totName));
		$nameComponents = explode(" ", $totName);
		$surname = end($nameComponents);
		$name = "";
		foreach (array_pop($nameComponents) as $n) {
			$name = $name.$n." ";
		}
		$name = trim($name);
    	$uId = registerUser($name, $surname, $username, $email, generateToken(16));
    	if($uId == null){
        	echo '{"exception":"An error occurred while registring a new account"}';
        	exit();
        }
    	$login = loginWithEmail($email);
    }
    echo json_encode($login);


