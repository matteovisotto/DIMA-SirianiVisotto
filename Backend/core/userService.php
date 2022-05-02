<?php

function registerUser($name, $surname, $username, $email, $password) {
	$salt = generateToken(16);
	$hashed = hash('sha256', $password.$salt);
	$sql = "INSERT INTO user (name, surname, email, username, password, salt) VALUES (?,?,?,?,?,?)";
	$db = getDatabaseConnection();
    $stmt = $db->prepare($sql);
    $stmt->bind_param("ssssss", $name, $surname, $email, $username, $hashed, $salt);
    if($stmt->execute()) {
    	$uId = $stmt->insert_id;
    	$stmt->close();
    	return $uId;
    }
	return null;
}

function getUserById($userId) {
	$sql = "SELECT id, name, surname, email, username, createdAt FROM user WHERE id=?";
	$db = getDatabaseConnection();
    $stmt = $db->prepare($sql);
    $stmt->bind_param("i", $userId);
	$stmt->execute();
	$result = $stmt->get_result();
	$stmt->close();
    if($result->num_rows == 1){
    	$row = $result->fetch_assoc();
		return $row;
    }
	return null;
}

function verifyPasswordByUserId($uId, $pwd){
	$sql = "SELECT * FROM user WHERE id=?";
	$db = getDatabaseConnection();
    $stmt = $db->prepare($sql);
    $stmt->bind_param("i", $uId);
    $stmt->execute();
    $result = $stmt->get_result();
    $stmt->close();
    $row = $result->fetch_assoc();
    $dbPassword = $row['password'];
    $salt = $row['salt'];
    $hashed = hash('sha256', $pwd.$salt);
    if($hashed == $dbPassword){
       return true;
    }
    return false;
}

function changeUserPassword($new, $userId) {
	$salt = generateToken(16);
	$hashed = hash('sha256', $new.$salt);
	$sql = "UPDATE user SET password=?, salt=? WHERE id=?";
	$db = getDatabaseConnection();
    $stmt = $db->prepare($sql);
    $stmt->bind_param("ssi", $hashed, $salt, $userId);
    if($stmt->execute()) {
    	$stmt->close();
    	return true;
    }
	$stmt->close();
	return false;
}

function updateUserInfo($userId, $name, $surname, $username){
	$sql = "UPDATE user SET name=?, surname=?, username=? WHERE id=?";
	$db = getDatabaseConnection();
    $stmt = $db->prepare($sql);
    $stmt->bind_param("sssi", $name, $surname, $username, $userId);
    if($stmt->execute()) {
    	$stmt->close();
    	return true;
    }
	$stmt->close();
	return false;
}