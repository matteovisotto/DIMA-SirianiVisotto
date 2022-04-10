<?php
/**
	 * #Method: GET
	 * #RequireAuth: false
	 * #Description: Get a product by id
	 * #Parameters: String amazonUrl - the url of the product
	 * #Optional Parameters: Boolean lastPriceOnly - if present only the last available price will be returned
	 * #Prameters in: query string
	 **/

if(!isset($_GET['amazonUrl']) || empty($_GET['amazonUrl'])){
	echo '{"exception":"Invalid or missing parameter"}';
	exit();
}

$lastPriceOnly = isset($_GET['lastPriceOnly']) ? true : false;

$productUrl = $_GET['amazonUrl'];
$product = getProductByUrl($productUrl);
if($product == null){
	echo '{"exception":"Product not found"}';
	exit();
}
if($lastPriceOnly){
	$product["price"] = getProductLastPriceByProductId($product['id'])['price'];
} else {
	$product['prices'] = getProductPricesByProductId($product['id']);
}

$product['images'] = getProductImagesByProductId($product['id']);
echo json_encode($product);