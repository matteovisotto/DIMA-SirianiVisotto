<?php
/**
	 * #Method: GET
	 * #RequireAuth: false
	 * #Description: Get the products by the drop between the last two prices ordered by drop percentage
	 * #Optional Parameters: Integer limit - number of results, Integer page - number of page
	 * #Parameters in: query string
	 **/

$page = isset($_GET['page']) ? $_GET['page'] : -1;

if(isset($_GET['limit']) || $_GET['page'] != -1){
	echo json_encode(getByLastPriceDropLimitPaging($_GET['limit'], $page, true));
} else {
	echo json_encode(getByLastPriceDrop(true));
}