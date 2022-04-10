<?php
/**
	 * #Method: POST
	 * #RequireAuth: true
	 * #Description: Remove a tracked product
	 * #Parameters: Integer productId - the id of the product to remove the tracking
	 * #Parametrs in: body
	 **/

$userId = apiLogin($_GET);
if(!isset($_POST['productId']) || empty($_POST['productId'])){
	echo '{"exception":"Invalid or missing parameters"}';
	exit();
}

$productId = $_POST['productId'];
if(removeTracking($userId, $productId)){
	echo '{"success":"Tracking removed correctly"}';
} else {
	echo '{"exception":"An error occurred while removing tracking"}';
}