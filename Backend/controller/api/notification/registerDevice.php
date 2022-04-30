<?php
/**
	 * #Method: POST
	 * #RequireAuth: false
	 * #Description: Register a new device for push notification
	 * #Parameters: String deviceId - A unique string to identify the device, String fcmToken - The firebase token for Cloud Messaging service, String email - The email of the logged user
	 * #Prameters in: body
	 **/
if(!isset($_POST['deviceId']) || empty($_POST['deviceId']) || !isset($_POST['fcmToken']) || empty($_POST['fcmToken'])){
	header("HTTP/1.1 400 - Bad request");
	exit();
}

$deviceId = $_POST['deviceId'];
$fcmToken = $_POST['fcmToken'];
$email = (!isset($_POST['email']) || $_POST['email']=="none") ? null : $_POST['email'];

if(notificationTokenExist($fcmToken)){
	$divice = getDeviceByNotificationToken($fcmToken);
	if($device['userEmail'] == null && $email != null) {
    	if(updateDeviceByDeviceId($deviceId, $fcmToken, $email)){
        	echo '{"success":"Registred"}';
        	exit();
        } else {
        	header("HTTP/1.0 500");
        	echo '{"error":"An error occurred while updating the email"}';
        	exit();
        }
    } else {
    		echo '{"success":"No action performed"}';
        	exit();
    }
    
} else {
	$device = getDeviceByDeviceId($deviceId);
	if($device == null){
    	if(registerDevice($deviceId, $fcmToken, $email)){
        	echo '{"success":"Registred"}';
        	exit();
    	} else {
       		header("HTTP/1.0 500");
        	echo '{"error":"An error occurred while updating the record"}';
        	exit();
    	}
    } else {
    	if(updateDeviceByDeviceId($deviceId, $fcmToken, $email)){
        	echo '{"success":"Registred"}';
        	exit();
    	} else {
       		header("HTTP/1.0 500");
        	echo '{"error":"An error occurred while updating fcmToken"}';
        	exit();
    	}
    }
    
}
