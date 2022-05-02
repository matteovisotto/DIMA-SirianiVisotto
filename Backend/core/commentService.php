<?php

function getCommentsByProductId($productId){
	$sql = "SELECT c.id, c.productId, c.comment, c.publishedAt, u.id AS userId, u.username, u.name, u.surname FROM comment AS c JOIN user AS u ON u.id=c.userId WHERE c.productId = ? ORDER BY c.publishedAt DESC";
	$db = getDatabaseConnection();
	$stmt = $db->prepare($sql);
	$stmt->bind_param("i", $productId);
	$stmt->execute();
	$result = $stmt->get_result();
	$stmt->close();
	$comments = array();
	while($row = $result->fetch_assoc()){
    	$comments[] = $row;	
    }
	return $comments;
}

function isUserCommentOwner($commentId, $userId){
	$sql = "SELECT 1 FROM comment WHERE id=? AND userId=?";
	$db = getDatabaseConnection();
	$stmt = $db->prepare($sql);
	$stmt->bind_param("ii", $commentId, $userId);
	$stmt->execute();
	$result = $stmt->get_result();
	$stmt->close();
	if($result->num_rows > 0){
    	return true;
    }
	return false;
}

function addComment($userId, $productId, $text){
	$sql = "INSERT INTO comment (userId, productId, comment) VALUES (?,?,?)";
	$db = getDatabaseConnection();
	$stmt = $db->prepare($sql);
	$stmt->bind_param("iis", $userId, $productId, $text);
	if($stmt->execute()){
    	$stmt->close();
    	return true;
    }
    $stmt->close();
    return false;
}

function updateComment($commentId, $text){
	$sql = "UPDATE comment SET comment=? WHERE id=?";
	$db = getDatabaseConnection();
	$stmt = $db->prepare($sql);
	$stmt->bind_param("si", $text, $commentId);
	if($stmt->execute()){
    	$stmt->close();
    	return true;
    }
    $stmt->close();
    return false;
}

function removeComment($commentId){
	$sql = "DELETE FROM comment WHERE id=?";
	$db = getDatabaseConnection();
	$stmt = $db->prepare($sql);
	$stmt->bind_param("i", $commentId);
	if($stmt->execute()){
    	$stmt->close();
    	return true;
    }
    $stmt->close();
    return false;
}