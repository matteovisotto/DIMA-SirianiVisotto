<?php
/**
	 * #Method: GET
	 * #RequireAuth: false
	 * #Description: Get most tracked product by page
	 * #Optional Parameters: Integer limit - number of results, Integer page - number of page
	 * #Parameters in: query string
	 **/

$limit = isset($_GET['limit']) ? $_GET['limit'] : 50;
$page = isset($_GET['page']) ? $_GET['page'] : -1;

echo json_encode(getMostTrackedPaging($limit,$page));