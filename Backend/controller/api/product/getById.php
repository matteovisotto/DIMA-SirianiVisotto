<?php
/**
	 * #Method: GET
	 * #RequireAuth: false
	 * #Description: Get a product by id
	 * #Parameters: Integer id - the Id of the product
	 * #Optional Parameters: Boolean lastPriceOnly - if present only the last available price will be returned
	 * #Prameters in: query string
	 **/

if(!isset($_GET['id']) || empty($_GET['id'])){
	echo '{"exception":"Invalid or missing parameter"}';
	exit();
}

$lastPriceOnly = isset($_GET['lastPriceOnly']) ? true : false;

$productId = $_GET['id'];
$product = getProductById($productId);
if($product == null){
	echo '{"exception":"Product not found"}';
	exit();
}
if($lastPriceOnly){
	$product["price"] = getProductLastPriceByProductId($productId)['price'];
} else {
	$product['prices'] = getProductPricesByProductId($productId);
}

$product['images'] = getProductImagesByProductId($productId);
echo json_encode($product);