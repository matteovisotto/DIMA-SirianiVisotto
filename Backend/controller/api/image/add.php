<?php
/**
	 * #Method: POST
	 * #RequireAuth: true
	 * #Description: Add a new image to an existing product
	 * #Parameters: Integer productId - The id of the product, String imageUrl - The url of the image to add
	 * #Prameters in: body
	 **/

$userId = apiLogin($_GET);
if(!isset($_POST['productId']) || empty($_POST['productId']) || !isset($_POST['imageUrl']) || empty($_POST['imageUrl'])){
	echo '{"exception":"Invalid or missing parameters"}';
	exit();
}
$productId = $_POST['productId'];
$imageUrl = $_POST['imageUrl'];

if(!productIdExists($productId)){
	echo '{"exception":"Invalid product"}';
	exit();
}

if(addImageToProduct($productId, $imageUrl)){
	echo '{"success":"Image added"}';
} else {
	echo '{"exception":"An error occurred while adding the image"}';
}

