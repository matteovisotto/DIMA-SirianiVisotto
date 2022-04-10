<?php

function generateToken($length){
	return bin2hex(openssl_random_pseudo_bytes($length/2));
}

function isAccessTokenFree($token) {
	$sql = "SELECT 1 FROM auth WHERE accessToken=?";
	$db = getDatabaseConnection();
    $stmt = $db->prepare($sql);
    $stmt->bind_param("s", $token);
    $stmt->execute();
    $result = $stmt->get_result();
    $stmt->close();
    if($result->num_rows > 0){
		return false;
    }
	return true;
}

function isRefreshTokenFree($token) {
	$sql = "SELECT 1 FROM auth WHERE refreshToken=?";
	$db = getDatabaseConnection();
    $stmt = $db->prepare($sql);
    $stmt->bind_param("s", $token);
    $stmt->execute();
    $result = $stmt->get_result();
    $stmt->close();
    if($result->num_rows > 0){
		return false;
    }
	return true;
}

function generateAccessToken(){
	$token = "";
	do {
    	$token = generateToken(32);
    } while (!isAccessTokenFree($token));
    return $token;
}

function generateRefreshToken(){
	$token = "";
	do {
    	$token = generateToken(64);
    } while (!isRefreshTokenFree($token));
    return $token;
}

function getExpireTime($accessToken) {
	$sql = "SELECT expireAt FROM auth WHERE accessToken=?";
	$db = getDatabaseConnection();
    $stmt = $db->prepare($sql);
    $stmt->bind_param("s", $accessToken);
    $stmt->execute();
    $result = $stmt->get_result();
    $stmt->close();
	if($result->num_rows == 1) {
    	$row = $result->fetch_assoc();
    	return $row["expireAt"];
    }
	return null;
}

function createLoginToken($userId) {
	$accessToken = generateAccessToken();
	$refreshToken = generateRefreshToken();
	$sql = "INSERT INTO auth (userId, accessToken, refreshToken) VALUES (?,?,?)";
	$db = getDatabaseConnection();
    $stmt = $db->prepare($sql);
    $stmt->bind_param("iss", $userId, $accessToken, $refreshToken);
	$stmt->execute();
	$response = array();
	$response["accessToken"] = $accessToken;
	$response["refreshToken"] = $refreshToken;
	$response["expireAt"] = getExpireTime($accessToken);
	return $response;
}

function verifyRefreshToken($refreshToken) {
	$sql = "SELECT userId FROM auth WHERE refreshToken=?";
	$db = getDatabaseConnection();
    $stmt = $db->prepare($sql);
    $stmt->bind_param("s", $refreshToken);
    $stmt->execute();
    $result = $stmt->get_result();
    $stmt->close();
	if($result->num_rows == 1) {
    	$row = $result->fetch_assoc();
    	return $row["userId"];
    }
	return null;
}

function refreshToken($refreshToken, $userId) {
	$accessToken = generateAccessToken();
	$sql = "UPDATE auth SET accessToken=? WHERE refreshToken=? AND userId=?";
	$db = getDatabaseConnection();
    $stmt = $db->prepare($sql);
    $stmt->bind_param("ssi", $accessToken, $refreshToken, $userId);
	$stmt->execute();
	$response = array();
	$response["accessToken"] = $accessToken;
	$response["expireAt"] = getExpireTime($accessToken);
	return $response;
}

function loginWithCredential($username, $password) {
	$sql = "SELECT * FROM user WHERE email=?";
	$db = getDatabaseConnection();
    $stmt = $db->prepare($sql);
    $stmt->bind_param("s", $username);
    $stmt->execute();
    $result = $stmt->get_result();
    $stmt->close();
	if($result->num_rows == 1) {
    	$row = $result->fetch_assoc();
    	$dbPassword = $row['password'];
    	$salt = $row['salt'];
    	$hashed = hash('sha256', $password.$salt);
    	if($hashed == $dbPassword){
        	return createLoginToken($row['id']);
        }
    }
	return null;
}

//Used in social login
function loginWithEmail($email) { 
	$sql = "SELECT * FROM user WHERE email=?";
	$db = getDatabaseConnection();
    $stmt = $db->prepare($sql);
    $stmt->bind_param("s", $email);
    $stmt->execute();
    $result = $stmt->get_result();
    $stmt->close();
	if($result->num_rows == 1) {
    	$row = $result->fetch_assoc();
        return createLoginToken($row['id']);
    }
	//Register user here
	return null;
}

function verifyAccessToken($accessToken) {
	$sql = "SELECT userId FROM auth WHERE accessToken=? AND expireAt > NOW()";
	$db = getDatabaseConnection();
    $stmt = $db->prepare($sql);
    $stmt->bind_param("s", $accessToken);
    $stmt->execute();
    $result = $stmt->get_result();
    $stmt->close();
	if($result->num_rows == 1) {
    	$row = $result->fetch_assoc();
        return $row['userId'];
    }
	return null;
}

function apiLogin($get) {
	if(!isset($get['token']) || empty($get['token'])){
    	header("HTTP/1.1 401 Unauthorized");
    	echo '{"exception":"Unauthorized"}';
    	exit();
    }
	$user = verifyAccessToken($get['token']);
	if($user == null){
    	header("HTTP/1.1 401 Unauthorized");
    	echo '{"exception":"Unauthorized"}';
    	exit();
    }
	return $user;
}

function logout($userId, $accessToken) {
	$sql = "DELETE FROM auth WHERE userId=? AND accessToken=?";
	$db = getDatabaseConnection();
    $stmt = $db->prepare($sql);
    $stmt->bind_param("ss", $userId, $accessToken);
    $stmt->execute();
    $stmt->close();
	return;
}