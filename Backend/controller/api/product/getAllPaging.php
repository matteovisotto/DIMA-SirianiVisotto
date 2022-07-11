<?php
/**
	 * #Method: GET
	 * #RequireAuth: false
	 * #Description: Get all the products
	 * #Optional Parameters: Boolean lastPriceOnly - if present only the last price update will be returned
	 * #Parameters in: query string
	 **/

$page = isset($_GET['page']) ? $_GET['page'] : -1;
$limit = isset($_GET['limit']) ? $_GET['limit'] : -1;

if ($page >= 0 && $limit > 0) {
	echo json_encode(getAllProductsPaging($page, $limit));
}

