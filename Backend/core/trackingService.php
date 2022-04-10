<?php

function addTracking($userId, $productId, $dropValue, $dropKey){
	$sql = "INSERT INTO tracking (userId, productId, dropValue, dropKey) VALUES (?,?,?,?)";
	$db = getDatabaseConnection();
	$stmt = $db->prepare($sql);
	$stmt->bind_param("iids", $userId, $productId, $dropValue, $dropKey);
	if($stmt->execute()){
    	$stmt->close();
    	return true; 
    } 
	$stmt->close();
    return false; 
}

function getAllTrackedProducts($userId){
	$sql = "SELECT p.id, p.name, p.description, p.link, p.createdAt, p.lastUpdate, t.trackingSince, t.dropKey, t.dropValue FROM product AS p JOIN tracking AS t ON t.productId=p.id WHERE t.userId=?";
	$db = getDatabaseConnection();
	$stmt = $db->prepare($sql);
	$stmt->bind_param("i", $userId);
	$stmt->execute();
	$result = $stmt->get_result();
	$stmt->close();
	$r = array();
	while($row = $result->fetch_assoc()){
    	$row['images'] = getProductImagesByProductId($row['id']);
    	$row['prices'] = getProductPricesByProductId($row['id']);
    	$r[] = $row;
    }
	return $r;
}

function getAllTrackedProductsLastPriceOnly($userId){
	$sql = "SELECT p.id, p.name, p.description, p.link, p.createdAt, t.trackingSince, t.dropKey, t.dropValue, a.price, MAX(a.updatedAt) AS lastUpdate FROM product AS p JOIN tracking AS t ON t.productId=p.id JOIN price AS a ON a.productId = p.id WHERE t.userId=? GROUP BY a.productId";
	$db = getDatabaseConnection();
	$stmt = $db->prepare($sql);
	$stmt->bind_param("i", $userId);
	$stmt->execute();
	$result = $stmt->get_result();
	$stmt->close();
	$r = array();
	while($row = $result->fetch_assoc()){
    	$row['images'] = getProductImagesByProductId($row['id']);
    	$r[] = $row;
    }
	return $r;
}

function removeTracking($userId, $productId){
	$sql = "DELETE FROM tracking WHERE userId=? AND productId=?";
	$db = getDatabaseConnection();
	$stmt = $db->prepare($sql);
	$stmt->bind_param("ii", $userId, $productId);
	if($stmt->execute()){
    	$stmt->close();
    	return true;
    }
	$stmt->close();
    return false;
}

function updateTrackingPreference($userId, $productId, $dropKey, $dropValue){
	$sql = "UPDATE tracking SET dropKey=?, dropValue=? WHERE userId=? AND productId=?";
	$db = getDatabaseConnection();
	$stmt = $db->prepare($sql);
	$stmt->bind_param("sdii", $dropKey, $dropValue, $userId, $productId);
	if($stmt->execute()){
    	$stmt->close();
    	return true;
    }
	$stmt->close();
    return false;
}

?>