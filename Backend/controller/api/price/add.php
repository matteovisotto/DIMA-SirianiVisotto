<?php
/**
	 * #Method: POST
	 * #RequireAuth: true
	 * #Description: Add a new price to an existing product
	 * #Parameters: Integer productId - The id of the product, Double price - The price to add
	 * #Prameters in: body
	 **/

$userId = apiLogin($_GET);
if(!isset($_POST['productId']) || empty($_POST['productId']) || !isset($_POST['price']) || empty($_POST['price'])){
	echo '{"exception":"Invalid or missing parameters"}';
	exit();
}
$productId = $_POST['productId'];
$price = $_POST['price'];

if(!productIdExists($productId)){
	echo '{"exception":"Invalid product"}';
	exit();
}

if(addPriceToProduct($productId, $price)){
	echo '{"success":"Price added"}';
} else {
	echo '{"exception":"An error occurred while adding the price"}';
}

