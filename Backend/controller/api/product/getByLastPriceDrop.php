<?php
/**
	 * #Method: GET
	 * #RequireAuth: false
	 * #Description: Get the products by the drop between the last two prices ordered by absolute drop
	 * #Optional Parameters: Integer limit - number of results
	 * #Parameters in: query string
	 **/

if(isset($_GET['limit'])){
	echo json_encode(getByLastPriceDropLimit($_GET['limit']));
} else {
	echo json_encode(getByLastPriceDrop());
}



