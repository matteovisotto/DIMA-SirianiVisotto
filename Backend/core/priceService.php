<?php
function getProductPricesByProductId($productId){
	$sql = "SELECT * FROM price WHERE productId=?";
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
	$sql = "SELECT p.price, MAX(p.updatedAt) AS updatedAt FROM price AS p WHERE p.productId=? GROUP BY p.productId";
	$db = getDatabaseConnection();
	$stmt = $db->prepare($sql);
	$stmt->bind_param("i", $productId);
	$stmt->execute();
	$result = $stmt->get_result();
	$row = $result->fetch_assoc();
	$stmt->close();
	return $row;
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