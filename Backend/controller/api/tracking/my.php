<?php
/**
	 * #Method: GET
	 * #RequireAuth: true
	 * #Description: Get all the tracked products by the user
	 * #Optional Parameters: Boolean lastPriceOnly - if present only the last updated price will be returned
	 * #Parametrs in: query string
	 **/

	$userId = apiLogin($_GET);
	$lastPriceOnly = isset($_GET['lastPriceOnly']) ? true : false;
	
	if($lastPriceOnly){
    	echo json_encode(getAllTrackedProductsLastPriceOnly($userId));
    } else {
    	echo json_encode(getAllTrackedProducts($userId));
    }