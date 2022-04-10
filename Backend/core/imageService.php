<?php
function getProductImagesByProductId($productId){
	$sql = "SELECT * FROM image WHERE productId=?";
	$db = getDatabaseConnection();
	$stmt = $db->prepare($sql);
	$stmt->bind_param("i", $productId);
	$stmt->execute();
	$result = $stmt->get_result();
	$r = array();
	while($row = $result->fetch_assoc()){
    	$r[] = $row['url'];
    }
	$stmt->close();
	return $r;
}

function addImageToProduct($productId, $imageUrl){
	$sql = "INSERT INTO image (productId, url) VALUES (?,?)";
	$db = getDatabaseConnection();
	$stmt = $db->prepare($sql);
	$stmt->bind_param("is", $productId, $imageUrl);
	if($stmt->execute()){
    	$stmt->close();
    	return true;
    }
	$stmt->close();
    return false;
}