<?php
/**
	 * #Method: POST
	 * #RequireAuth: true
	 * #Description: Add a comment to a given product
	 * #Parameters: Integer productId - The id of the product, String text - The text of the comment
	 * #Parametrs in: body
	 **/

if(!isset($_POST['productId']) || empty($_POST['productId']) || !isset($_POST['text']) || empty($_POST['text'])){
	echo '{"exception": "Invalid or missing parameters"}';
	exit();
}

$userId = apiLogin($_GET);
$productId = $_POST['productId'];
$text = htmlspecialchars($_POST['text'], ENT_QUOTES);

if(!productIdExists($productId)){
	echo '{"exception":"Invalid product"}';
	exit();
}

if(addComment($userId, $productId, $text)){
	$tokens = checkForCommentNotification($productId, $userId);
	sendProductCommentNotification($tokens, $productId);
	echo '{"success":"Comment successfully added"}';
} else {
	echo '{"exception":"An error occurred while adding the comment"}';
}