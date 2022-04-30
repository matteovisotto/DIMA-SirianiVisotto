<?php
/**
	 * #Method: GET
	 * #RequireAuth: false
	 * #Description: Get most tracked product
	 * #Optional Parameters: Integer limit - number of results
	 * #Parameters in: query string
	 **/

$limit = isset($_GET['limit']) ? $_GET['limit'] : 100;

echo json_encode(getMostTracked($limit));


