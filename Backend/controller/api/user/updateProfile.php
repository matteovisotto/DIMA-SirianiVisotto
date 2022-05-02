<?php
	/**
	 * #Method: POST
	 * #RequireAuth: true
	 * #Description: Update current user information
	 * #Parameters: String name - Name of the user, Stirng surname - Surname of the user, String username - Username for the user
	 * #Parameters in: body
	 **/

	$userId = apiLogin($_GET);
	
	if(!isset($_POST['name']) || empty($_POST['name']) || !isset($_POST['surname']) || empty($_POST['surname']) || !isset($_POST['username']) || empty($_POST['username'])){
    	echo '{"exception":"Invalid or missing parameters"}';
    	exit();
    }
	
	if(updateUserInfo($userId, $_POST['name'], $_POST['surname'], $_POST['username'])){
    	echo '{"success":"Account updated"}';
    	exit();
    }
	echo '{"exception":"An error occurred while updating the account"}';
    	exit();

	
?>
