<?php
/**
	 * #Method: POST
	 * #RequireAuth: true
	 * #Description: User add a new tracked product by id
	 * #Parameters: Integer id - id of the product
	 * #Optional Parameters: Double dropValue - the value of gap to be notified about the product, String dropKey - the unit of which dropValue refers to (none - percentage - diff)
	 * #Parametrs in: body
	 **/

$userId = apiLogin($_GET);
if(!isset($_POST["id"]) || empty($_POST["id"])){
    echo '{"exception":"Invalid or missing parameters"}';
    exit();
}
$dropValue = isset($_POST['dropValue']) ? $_POST['dropValue'] : 0;
$dropKey = isset($_POST['dropKey']) ? $_POST['dropKey'] : "none";
$commentPolicy = isset($_POST['commentPolicy']) ? $_POST['commentPolicy'] : "never";
$productId = $_POST['id'];
if(!productIdExists($productId)){
	echo '{"exception":"Invalid product"}';
    exit();
}

if(addTracking($userId,$productId, $dropValue, $dropKey, $commentPolicy)){
	echo '{"success":"Added and tracked", "productId":'.$productId.'}';
} else {
	echo '{"exception":"Unable to trace the product"}';
}

?>