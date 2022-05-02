<?php
	/**
	 * #Method: POST
	 * #RequireAuth: true
	 * #Description: Update current user password
	 * #Parameters: String oldPassword - Old user password, Stirng newPassword - New user password, String newPasswordCnf - Confirmation for the new password
	 * #Parameters in: body
	 **/

	$userId = apiLogin($_GET);
	
	if(!isset($_POST['oldPassword']) || empty($_POST['oldPassword']) || !isset($_POST['newPassword']) || empty($_POST['newPassword']) || !isset($_POST['newPasswordCnf']) || empty($_POST['newPasswordCnf'])){
    	echo '{"exception":"Invalid or missing parameters"}';
    	exit();
    }
	
	if(!verifyPasswordByUserId($userId, $_POST['oldPassword'])){
        echo '{"exception":"Wrong old password"}';
    	exit();
    }

	if($_POST['newPassword'] != $_POST['newPasswordCnf']){
    	echo '{"exception":"New password confirmation doesn\'t match"}';
    	exit();
    }
	
	if(changeUserPassword($_POST['newPassword'], $userId)){
    	echo '{"success":"Password changes"}';
    	exit();
    }
	echo '{"exception":"An error occurred while changing the password"}';
    	exit();

	
?>