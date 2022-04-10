<?php
/**
	 * #Method: GET
	 * #RequireAuth: false
	 * #Description: Get all the products
	 * #Optional Parameters: Boolean lastPriceOnly - if present only the last price update will be returned
	 * #Parameters in: query string
	 **/

$lastPriceOnly = isset($_GET['lastPriceOnly']) ? true : false;

if($lastPriceOnly){
	echo json_encode(getAllProductsLastPrice());
} else {
	echo json_encode(getAllProducts());
}


