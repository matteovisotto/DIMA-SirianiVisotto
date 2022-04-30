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