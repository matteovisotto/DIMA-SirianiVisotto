<?php
/**
	 * #Method: GET
	 * #RequireAuth: false
	 * #Description: Get the products by the drop between the highest and lowest price ordered by drop percentage
	 * #Optional Parameters: Integer limit - number of results
	 * #Parameters in: query string
	 **/

if(isset($_GET['limit'])){
	echo json_encode(getByPriceDropLimit($_GET['limit'], true));
} else {
	echo json_encode(getByPriceDrop(true));
}



