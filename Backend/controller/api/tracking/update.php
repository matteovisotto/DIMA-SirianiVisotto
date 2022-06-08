<?php
/**
	 * #Method: POST
	 * #RequireAuth: true
	 * #Description: Updated user preferences on a given tracked product
	 * #Parameters: Integer productId - id of the product the user is tracing, Double dropValue - the value of gap to be notified about the product, String dropKey - the unit of which dropValue refers to (none - percentage - diff)
	 * #Parametrs in: body
	 **/

$userId = apiLogin($_GET);
if(!isset($_POST['productId']) || empty($_POST['productId']) || !isset($_POST['dropValue']) || empty($_POST['dropValue']) || !isset($_POST['dropKey']) || empty($_POST['dropKey'])){
	echo '{"exception":"Invalid or missing paameters"}';
	exit();
}
$productId = $_POST['productId'];
$dropKey = $_POST['dropKey'];
$dropValue = $_POST['dropValue'];
$commentPolicy = isset($_POST['commentPolicy']) ? $_POST['commentPolicy'] : "never";
if (updateTrackingPreference($userId, $productId, $dropKey, $dropValue, $commentPolicy)){
	echo '{"success":"Preferences correctly updated"}';
} else {
	echo '{"exception":"Unable to update preferences"}';
}