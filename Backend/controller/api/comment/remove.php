<?php
/**
	 * #Method: POST
	 * #RequireAuth: true
	 * #Description: Remove a comment to a given product
	 * #Parameters: Integer commentId - The id of the comment
	 * #Parametrs in: body
	 **/

if(!isset($_POST['commentId']) || empty($_POST['commentId'])){
	echo '{"exception": "Invalid or missing parameters"}';
	exit();
}

$userId = apiLogin($_GET);
$commentId = $_POST['commentId'];
if(!isUserCommentOwner($commentId, $userId)){
	echo '{"exception":"Invalid comment"}';
	exit();
}

if(removeComment($commentId)){
	echo '{"success":"Comment successfully removed"}';
} else {
	echo '{"exception":"An error occurred while removing the comment"}';
}
