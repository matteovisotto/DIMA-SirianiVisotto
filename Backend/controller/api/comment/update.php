<?php
/**
	 * #Method: POST
	 * #RequireAuth: true
	 * #Description: Updated a comment to of the user
	 * #Parameters: Integer commentId - The id of the comment, String text - The text of the comment
	 * #Parametrs in: body
	 **/

if(!isset($_POST['commentId']) || empty($_POST['commentId']) || !isset($_POST['text']) || empty($_POST['text'])){
	echo '{"exception": "Invalid or missing parameters"}';
	exit();
}

$userId = apiLogin($_GET);
$commentId = $_POST['commentId'];
$text = htmlspecialchars($_POST['text'], ENT_QUOTES);

if(!isUserCommentOwner($commentId, $userId)){
	echo '{"exception":"Invalid comment"}';
	exit();
}

if(updateComment($commentId, $text)){
	echo '{"success":"Comment successfully updated"}';
} else {
	echo '{"exception":"An error occurred while updating the comment"}';
}