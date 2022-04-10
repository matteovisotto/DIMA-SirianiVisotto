<?php
	/**
	 * #Method: GET
	 * #RequireAuth: true
	 * #Description: Return all the attributes of the logged user
	 **/

	$userId = apiLogin($_GET);
	$user = getUserById($userId);
	if(is_null($user)) {
    	echo '{"exception":"An error occurred"}';
    	exit();
    }
	echo json_encode($user);
?>
