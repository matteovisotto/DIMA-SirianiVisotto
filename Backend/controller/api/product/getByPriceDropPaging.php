<?php
/**
	 * #Method: GET
	 * #RequireAuth: false
	 * #Description: Get the products by the drop between the highest and lowest price ordered by absolute drop
	 * #Optional Parameters: Integer limit - number of results, Integer page - number of page
	 * #Parameters in: query string
	 **/

$page = isset($_GET['page']) ? $_GET['page'] : -1;

if(isset($_GET['limit']) || $page != -1){
	echo json_encode(getByPriceDropLimitPaging($_GET['limit'], $page));
} else {
	echo json_encode(getByPriceDrop());
}