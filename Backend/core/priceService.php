<?php
function getProductPricesByProductId($productId){
	$sql = "SELECT * FROM price WHERE productId=?"; //ORDER BY updatedAt DESC LIMIT 60
	$db = getDatabaseConnection();
	$stmt = $db->prepare($sql);
	$stmt->bind_param("i", $productId);
	$stmt->execute();
	$result = $stmt->get_result();
	$r = array();
	while($row = $result->fetch_assoc()){
    	$x = array();
    	$x['price'] = $row['price'];
    	$x['updatedAt'] = $row['updatedAt'];
    	$r[] = $x;
    }
	$stmt->close();
	return $r;
}

function getProductLastPriceByProductId($productId){
	//$sql = "SELECT p.price, MAX(p.updatedAt) AS updatedAt FROM price AS p WHERE p.productId=? GROUP BY p.productId";
	$sql = "SELECT p.price, p.updatedAt AS updatedAt FROM price AS p WHERE p.updatedAt = (SELECT MAX(p2.updatedAt) FROM price AS p2 WHERE p.productId = p2.productId) AND p.productId=?";
	$db = getDatabaseConnection();
	$stmt = $db->prepare($sql);
	$stmt->bind_param("i", $productId);
	$stmt->execute();
	$result = $stmt->get_result();
	$row = $result->fetch_assoc();
	$stmt->close();
	return $row;
}

function getFirstPriceAfterDateByProductId($productId, $date){
	$sql = "SELECT p.price, p.updatedAt FROM price AS p WHERE p.productId=? AND p.updatedAt > ? ORDER BY p.updatedAt ASC LIMIT 1";
	$db = getDatabaseConnection();
	$stmt = $db->prepare($sql);
	$stmt->bind_param("id", $productId, $date);
	$stmt->execute();
	$result = $stmt->get_result();
	$stmt->close();
	if($result->num_rows == 1){
    	return $result->fetch_assoc();
    }
	return null;
}	

function getFirstPriceBeforeDateByProductId($productId, $date){
	$sql = "SELECT p.price, p.updatedAt FROM price AS p WHERE p.productId=? AND p.updatedAt < ? ORDER BY p.updatedAt DESC LIMIT 1";
	$db = getDatabaseConnection();
	$stmt = $db->prepare($sql);
	$stmt->bind_param("id", $productId, $date);
	$stmt->execute();
	$result = $stmt->get_result();
	$stmt->close();
	if($result->num_rows == 1){
    	return $result->fetch_assoc();
    }
	return null;
}

function addPriceToProduct($productId, $price){
	$sql = "INSERT INTO price (productId, price) VALUES (?,?)";
	$db = getDatabaseConnection();
	$stmt = $db->prepare($sql);
	$stmt->bind_param("id", $productId, $price);
	if($stmt->execute()){
    	$stmt->close();
    	return true;
    }
	$stmt->close();
    return false;
}