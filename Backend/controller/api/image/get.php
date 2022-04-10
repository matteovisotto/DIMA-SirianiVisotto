<?php
/**
	 * #Method: GET
	 * #RequireAuth: false
	 * #Description: Get all the images of a given product
	 * #Parameters: Integer productId - The id of the product
	 * #Prameters in: query string
	 **/

if(!isset($_GET['productId']) || empty($_GET['productId'])){
	echo '{"exception":"Invalid or missing parameters"}';
	exit();
}
$productId = $_GET['productId'];
if(!productIdExists($productId)){
	echo '{"exception":"Invalid product"}';
	exit();
}

$response = array();
$response['productId'] = $productId;
$response['images'] = getProductImagesByProductId($productId);
echo json_encode($response);