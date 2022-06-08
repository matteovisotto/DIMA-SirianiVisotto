<?php

function registerDevice($deviceId, $fcmToken, $email){
	$sql = "INSERT INTO device (deviceId, fcmToken, userEmail) VALUES (?,?,?)";
	$db = getDatabaseConnection();
	$stmt = $db->prepare($sql);
	$stmt->bind_param("sss", $deviceId, $fcmToken, $email);
	$result = $stmt->execute();
	$stmt->close();
	return $result;
}

function updateDeviceByDeviceId($deviceId, $fcmToken, $email){
	$sql = "UPDATE device SET fcmToken=?, userEmail=? WHERE deviceId=?";
	$db = getDatabaseConnection();
	$stmt = $db->prepare($sql);
	$stmt->bind_param("sss", $fcmToken, $email, $deviceId);
	$result = $stmt->execute();
	$stmt->close();
	return $result;
}

function getNotificationTokenByEmail($email) {
	$sql = "SELECT fcmToken FROM device WHERE userEmail=?";
	$db = getDatabaseConnection();
	$stmt = $db->prepare($sql);
	$stmt->bind_param("s", $email);
	$stmt->execute();
	$result = $stmt->get_result();
	$stmt->close();
	$arr = array();
	while($row = $result->fetch_assoc()){
    	$arr[] = $row['fcmToken'];
    }
	return $arr;
}

function notificationTokenExist($fcmToken){
	$sql = "SELECT 1 FROM device WHERE fcmToken=?";
	$db = getDatabaseConnection();
	$stmt = $db->prepare($sql);
	$stmt->bind_param("s", $fcmToken);
	$stmt->execute();
	$result = $stmt->get_result();
	$stmt->close();
	if($result->num_rows == 0){
    	return false;
    }
	return true;
}

function getDeviceByNotificationToken($fcmToken) {
	$sql = "SELECT * FROM device WHERE fcmToken=?";
	$db = getDatabaseConnection();
	$stmt = $db->prepare($sql);
	$stmt->bind_param("s", $fcmToken);
	$stmt->execute();
	$result = $stmt->get_result();
	$stmt->close();
	if($result->num_rows==0){
    	return null;
    }
	return $result->fetch_assoc();
}

function getDeviceByDeviceId($deviceId) {
	$sql = "SELECT * FROM device WHERE deviceId=?";
	$db = getDatabaseConnection();
	$stmt = $db->prepare($sql);
	$stmt->bind_param("s", $deviceId);
	$stmt->execute();
	$result = $stmt->get_result();
	$stmt->close();
	if($result->num_rows==0){
    	return null;
    }
	return $result->fetch_assoc();
}

function getNotificationTokenByUserId($uId) {
	$sql = "SELECT d.fcmToken FROM device AS d JOIN user AS u ON d.userEmail=u.email WHERE u.id=?";
	$db = getDatabaseConnection();
	$stmt = $db->prepare($sql);
	$stmt->bind_param("i", $uId);
	$stmt->execute();
	$result = $stmt->get_result();
	$stmt->close();
	$arr = array();
	while($row = $result->fetch_assoc()){
    	$arr[] = $row['fcmToken'];
    }
	return $arr;
}

function removeUserFromDeviceByEmail($email, $deviceId) {
	$sql = "UPDATE device SET userEmail=null WHERE userEmail=? AND deviceId=?";
	$db = getDatabaseConnection();
	$stmt = $db->prepare($sql);
	$stmt->bind_param("ss", $email, $deviceId);
	$result = $stmt->execute();
	$stmt->close();
	return $result;
}

function removeUserFromDeviceById($uId, $deviceId) {
	$sql = "UPDATE device AS d JOIN user AS u ON d.userEmail=u.email SET d.userEmail=null WHERE u.id=? AND d.deviceId=?";
	$db = getDatabaseConnection();
	$stmt = $db->prepare($sql);
	$stmt->bind_param("is", $uId, $deviceId);
	$result = $stmt->execute();
	$stmt->close();
	return $result;
}

function getAllNotificationTokens() {
	$sql = "SELECT fcmToken FROM device";
	$db = getDatabaseConnection();
	$stmt = $db->prepare($sql);
	$stmt->execute();
	$result = $stmt->get_result();
	$stmt->close();
	$arr = array();
	while($row = $result->fetch_assoc()){
    	$arr[] = $row['fcmToken'];
    }
	return $arr;
}

function getAllUnloggetNotificationTokens(){
	$sql = "SELECT fcmToken FROM device WHERE userEmail=null";
	$db = getDatabaseConnection();
	$stmt = $db->prepare($sql);
	$stmt->bind_param("i", $uId);
	$stmt->execute();
	$result = $stmt->get_result();
	$stmt->close();
	$arr = array();
	while($row = $result->fetch_assoc()){
    	$arr[] = $row['fcmToken'];
    }
	return $arr;
}

function sendProductNotification($tokens, $productName, $productId) {
	if(count($tokens) == 0){
    	return;
    }
	
	$url = 'https://fcm.googleapis.com/fcm/send';
    //building headers for the request
    $headers = array(
    	'Authorization: key=AAAAEC5gQj4:APA91bHN4-EtPFnG0XtyRDcwlpI99w1K3OPbVkqvy40nJrvDq4b-Mlmmj5RVa36T5HDHfazYU6dv3KvKGHtTjKuI-9y92RMpH6D5EA29qbB_Ji6XdM01yUu-9TnBpZWWvjTJpBNIXvjs',
        'Content-Type: application/json'
    );

	$fields = array(
    	'registration_ids' => $tokens,
        'notification' => array(
        	"title"=> "New price drop",
     		"body"=> $productName.' has now a lower price',
     		"sound"=> "default",
        	"badge" => 1,
    		"mutable_content" => true
     	),
		'data' => array(
            "type"=>"product",
        	"lang" => array(
            	"en" => array(
                	"title"=>"New price drop",
                	"body" => $productName." has a lower price now"
                ),
            	"it" => array(
                	"title"=>"Nuova variazione di prezzo",
                	"body" => $productName." ha ora un prezzo inferiore"
                ),
            ),
            "productId"=>$productId
         )
    );
 
    //Initializing curl to open a connection
    $ch = curl_init();
    //Setting the curl url
    curl_setopt($ch, CURLOPT_URL, $url);
    //setting the method as post
    curl_setopt($ch, CURLOPT_POST, true);
    //adding headers 
    curl_setopt($ch, CURLOPT_HTTPHEADER, $headers);
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
 	//disabling ssl support
    curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
	//adding the fields in json format 
    curl_setopt($ch, CURLOPT_POSTFIELDS, json_encode($fields));
	//finally executing the curl request 
    $result = curl_exec($ch);
    //Now close the connection
    curl_close($ch);
}

function sendProductCommentNotification($tokens, $productId) {
	if(count($tokens) == 0){
    	return;
    }
	
	$url = 'https://fcm.googleapis.com/fcm/send';
    //building headers for the request
    $headers = array(
    	'Authorization: key=AAAAEC5gQj4:APA91bHN4-EtPFnG0XtyRDcwlpI99w1K3OPbVkqvy40nJrvDq4b-Mlmmj5RVa36T5HDHfazYU6dv3KvKGHtTjKuI-9y92RMpH6D5EA29qbB_Ji6XdM01yUu-9TnBpZWWvjTJpBNIXvjs',
        'Content-Type: application/json'
    );

	$fields = array(
    	'registration_ids' => $tokens,
        'notification' => array(
        	"title"=> "New comment",
     		"body"=> 'A new comment has been added on a tracked product',
     		"sound"=> "default",
        	"badge" => 1,
    		"mutable_content" => true
     	),
		'data' => array(
            "type"=>"product",
        	"lang" => array(
            	"en" => array(
                	"title"=>"New comment",
                	"body" => "A new comment has been added on a tracked product"
                ),
            	"it" => array(
                	"title"=>"Nuovo commento",
                	"body" =>"Un nuovo commento è stato aggiunto ad un prodotto tracciato"
                ),
            ),
            "productId"=>$productId
         )
    );
 
    //Initializing curl to open a connection
    $ch = curl_init();
    //Setting the curl url
    curl_setopt($ch, CURLOPT_URL, $url);
    //setting the method as post
    curl_setopt($ch, CURLOPT_POST, true);
    //adding headers 
    curl_setopt($ch, CURLOPT_HTTPHEADER, $headers);
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
 	//disabling ssl support
    curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
	//adding the fields in json format 
    curl_setopt($ch, CURLOPT_POSTFIELDS, json_encode($fields));
	//finally executing the curl request 
    $result = curl_exec($ch);
    //Now close the connection
    curl_close($ch);
}