<?php

function addTracking($userId, $productId, $dropValue, $dropKey, $commentPolicy){
	$sql = "INSERT INTO tracking (userId, productId, dropValue, dropKey, commentPolicy) VALUES (?,?,?,?,?)";
	$db = getDatabaseConnection();
	$stmt = $db->prepare($sql);
	$stmt->bind_param("iidss", $userId, $productId, $dropValue, $dropKey, $commentPolicy);
	if($stmt->execute()){
    	$stmt->close();
    	return true; 
    } 
	$stmt->close();
    return false; 
}

function getAllTrackedProducts($userId){
	$sql = "SELECT p.id, p.name, p.shortName, p.category, p.description, p.link, p.createdAt, p.lastUpdate, p.highestPrice, p.lowestPrice, t.trackingSince, t.dropKey, t.dropValue, t.commentPolicy, l.priceDrop, l.priceDropPercentage FROM product AS p JOIN tracking AS t ON t.productId=p.id JOIN lastPriceDrop AS l ON p.id = l.productId WHERE t.userId=?";
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

function getAllTrackedProductsLimit($userId, $limit){
	$sql = "SELECT p.id, p.name, p.shortName, p.category, p.description, p.link, p.createdAt, p.lastUpdate, p.highestPrice, p.lowestPrice, t.trackingSince, t.dropKey, t.dropValue, t.commentPolicy, l.priceDrop, l.priceDropPercentage FROM product AS p JOIN tracking AS t ON t.productId=p.id JOIN lastPriceDrop AS l ON p.id = l.productId WHERE t.userId=? ORDER BY t.trackingSince DESC LIMIT ?";
	$db = getDatabaseConnection();
	$stmt = $db->prepare($sql);
	$stmt->bind_param("ii", $userId, $limit);
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

function isUserTrackingProduct($userId, $productId){
	$sql = "SELECT 1 FROM tracking WHERE userId=? AND productId=?";
	$db = getDatabaseConnection();
	$stmt = $db->prepare($sql);
	$stmt->bind_param("ii", $userId, $productId);
	$stmt->execute();
	$result = $stmt->get_result();
	$stmt->close();
	return $result->num_rows > 0;
}

function getTrackingProperties($userId, $productId){
	$sql = "SELECT * FROM tracking WHERE userId=? AND productId=?";
	$db = getDatabaseConnection();
	$stmt = $db->prepare($sql);
	$stmt->bind_param("ii", $userId, $productId);
	$stmt->execute();
	$result = $stmt->get_result();
	$stmt->close();
	return $result->fetch_assoc();
}

function getAllTrackedProductsLastPriceOnly($userId){
	//$sql = "SELECT p.id, p.name, p.description, p.link, p.createdAt, t.trackingSince, t.dropKey, t.dropValue, a.price, MAX(a.updatedAt) AS lastUpdate FROM product AS p JOIN tracking AS t ON t.productId=p.id JOIN price AS a ON a.productId = p.id WHERE t.userId=? GROUP BY a.productId";
	$sql = "SELECT p.id, p.name, p.shortName, p.category, p.description, p.link, p.createdAt, p.highestPrice, p.lowestPrice, t.trackingSince, t.dropKey, t.dropValue, a.price, a.updatedAt AS lastUpdate, t.commentPolicy, l.priceDrop, l.priceDropPercentage FROM product AS p JOIN tracking AS t ON t.productId=p.id JOIN price AS a ON a.productId = p.id JOIN lastPriceDrop AS l ON p.id = l.productId WHERE t.userId=? AND a.updatedAt=(SELECT MAX(p2.updatedAt) FROM price AS p2 WHERE a.productId = p2.productId) ORDER BY t.trackingSince ASC";
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

function getAllTrackedProductsLastPriceOnlyLimit($userId, $limit){
	//$sql = "SELECT p.id, p.name, p.description, p.link, p.createdAt, t.trackingSince, t.dropKey, t.dropValue, a.price, MAX(a.updatedAt) AS lastUpdate FROM product AS p JOIN tracking AS t ON t.productId=p.id JOIN price AS a ON a.productId = p.id WHERE t.userId=? GROUP BY a.productId";
	$sql = "SELECT p.id, p.name, p.shortName, p.category, p.description, p.link, p.createdAt, p.highestPrice, p.lowestPrice, t.trackingSince, t.dropKey, t.dropValue, a.price, a.updatedAt AS lastUpdate, t.commentPolicy FROM product AS p JOIN tracking AS t ON t.productId=p.id JOIN price AS a ON a.productId = p.id WHERE t.userId=? AND a.updatedAt=(SELECT MAX(p2.updatedAt) FROM price AS p2 WHERE a.productId = p2.productId) ORDER BY t.trackingSince DESC LIMIT ?";
	$db = getDatabaseConnection();
	$stmt = $db->prepare($sql);
	$stmt->bind_param("ii", $userId, $limit);
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

function updateTrackingPreference($userId, $productId, $dropKey, $dropValue, $commentPolicy){
	$sql = "UPDATE tracking SET dropKey=?, dropValue=?, commentPolicy=? WHERE userId=? AND productId=?";
	$db = getDatabaseConnection();
	$stmt = $db->prepare($sql);
	$stmt->bind_param("sdsii", $dropKey, $dropValue, $commentPolicy, $userId, $productId);
	if($stmt->execute()){
    	$stmt->close();
    	return true;
    }
	$stmt->close();
    return false;
}

function getAllTrackersByProductId($productId){
	$sql = "SELECT * FROM tracking WHERE productId=?";
	$db = getDatabaseConnection();
	$stmt = $db->prepare($sql);
	$stmt->bind_param("i", $productId);
	$stmt->execute();
	$result = $stmt->get_result();
	$stmt->close();
	$r = array();
	while($row = $result->fetch_assoc()){
    	$r[] = $row;
    }
	return $r;
}

function getAllTrackersWithNotificationByProductId($productId){
	$sql = "SELECT * FROM tracking WHERE productId=? AND dropKey != 'none'";
	$db = getDatabaseConnection();
	$stmt = $db->prepare($sql);
	$stmt->bind_param("i", $productId);
	$stmt->execute();
	$result = $stmt->get_result();
	$stmt->close();
	$r = array();
	while($row = $result->fetch_assoc()){
    	$r[] = $row;
    }
	return $r;
}

function getAllTrackersWithCommentNotificationByProductId($productId, $userId){
	$sql = "SELECT * FROM tracking WHERE productId=? AND userId != ? AND commentPolicy != 'none'";
	$db = getDatabaseConnection();
	$stmt = $db->prepare($sql);
	$stmt->bind_param("ii", $productId, $userId);
	$stmt->execute();
	$result = $stmt->get_result();
	$stmt->close();
	$r = array();
	while($row = $result->fetch_assoc()){
    	$r[] = $row;
    }
	return $r;
}

?>