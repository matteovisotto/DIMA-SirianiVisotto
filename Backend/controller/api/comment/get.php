<?php
/**
	 * #Method: GET
	 * #RequireAuth: false
	 * #Description: Get all the comments of a given product
	 * #Parameters: Integer productId - The id of the product
	 * #Parametrs in: query string
	 **/

if(!isset($_GET['productId']) || empty($_GET['productId'])){
	echo '{"exception": "Invalid or missing parameters"}';
	exit();
}

$productId = $_GET['productId'];

if(!productIdExists($productId)){
	echo '{"exception":"Invalid product"}';
	exit();
}

$comments = getCommentsByProductId($productId);
$response = array();
$response['productId'] = intval($productId);
$response['numberOfComments'] = count($comments);
$response['comments'] = $comments;

echo json_encode($response);