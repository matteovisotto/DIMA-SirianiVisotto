<?php
/**
	 * #Method: GET
	 * #RequireAuth: false
	 * #Description: Get the products by the drop between the last two prices ordered by drop percentage
	 * #Optional Parameters: Integer limit - number of results, Boolean lastPriceOnly - get only the last price (default true)
	 * #Parameters in: query string
	 **/

$lastPriceOnly = isset($_GET['lastPriceOnly']) ? ($_GET['lastPriceOnly'] == 'f' ? false : true) : true;

if($lastPriceOnly){
	if(isset($_GET['limit'])){
		echo json_encode(getByLastPriceDropLimit($_GET['limit'], true));
	} else {
		echo json_encode(getByLastPriceDrop(true));
	}
} else {
	if(isset($_GET['limit'])){
		echo json_encode(getByLastPriceDropLimitAllPrices($_GET['limit'], true));
	} else {
		echo json_encode(getByLastPriceDropAllPrices(true));
	}
}





