<?php
/**
	 * #Method: GET
	 * #RequireAuth: true
	 * #Description: Get the status of a product
	 * #Parameters: Integer productId - The id of the product to verify
	 * #Parametrs in: query string
	 **/

	$userId = apiLogin($_GET);
	
	if(!isset($_GET['productId']) || empty($_GET['productId'])){
    	echo '{"exception":"Invalid or missing paramenters"}';
    	exit();
    }
	
	$response = array();

	$status = isUserTrackingProduct($userId, $_GET['productId']);

	$response['tracked'] = $status;

	if($status){
    	$prop = getTrackingProperties($userId, $_GET['productId']);
    	$response['trackingSince'] = $prop['trackingSince'];
    	$response['dropKey'] = $prop['dropKey'];
    	$response['dropValue'] = $prop['dropValue'];
    	$response['commentPolicy'] = $prop['commentPolicy'];
    } 

	echo json_encode($response);