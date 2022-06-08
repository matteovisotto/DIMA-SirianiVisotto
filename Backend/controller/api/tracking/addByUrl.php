<?php
/**
	 * #Method: POST
	 * #RequireAuth: true
	 * #Description: User add a new tracked product by URL
	 * #Parameters: String amazonUrl - url of the product
	 * #Optional Parameters: Double dropValue - the value of gap to be notified about the product, String dropKey - the unit of which dropValue refers to (none - percentage - diff)
	 * #Parametrs in: body
	 **/

$userId = apiLogin($_GET);
if(!isset($_POST["amazonUrl"]) || empty($_POST["amazonUrl"])){
    echo '{"exception":"Invalid or missing parameters"}';
    exit();
}
$dropValue = isset($_POST['dropValue']) ? $_POST['dropValue'] : 0;
$dropKey = isset($_POST['dropKey']) ? $_POST['dropKey'] : "none";
$commentPolicy = isset($_POST['commentPolicy']) ? $_POST['commentPolicy'] : "never";
$amazonUrl = explode("?", $_POST["amazonUrl"])[0];
$unwanted_array = array(    'Š'=>'S', 'š'=>'s', 'Ž'=>'Z', 'ž'=>'z', 'À'=>'A', 'Á'=>'A', 'Â'=>'A', 'Ã'=>'A', 'Ä'=>'A', 'Å'=>'A', 'Æ'=>'A', 'Ç'=>'C', 'È'=>'E', 'É'=>'E',
                            'Ê'=>'E', 'Ë'=>'E', 'Ì'=>'I', 'Í'=>'I', 'Î'=>'I', 'Ï'=>'I', 'Ñ'=>'N', 'Ò'=>'O', 'Ó'=>'O', 'Ô'=>'O', 'Õ'=>'O', 'Ö'=>'O', 'Ø'=>'O', 'Ù'=>'U',
                            'Ú'=>'U', 'Û'=>'U', 'Ü'=>'U', 'Ý'=>'Y', 'Þ'=>'B', 'ß'=>'Ss', 'à'=>'a', 'á'=>'a', 'â'=>'a', 'ã'=>'a', 'ä'=>'a', 'å'=>'a', 'æ'=>'a', 'ç'=>'c',
                            'è'=>'e', 'é'=>'e', 'ê'=>'e', 'ë'=>'e', 'ì'=>'i', 'í'=>'i', 'î'=>'i', 'ï'=>'i', 'ð'=>'o', 'ñ'=>'n', 'ò'=>'o', 'ó'=>'o', 'ô'=>'o', 'õ'=>'o',
                            'ö'=>'o', 'ø'=>'o', 'ù'=>'u', 'ú'=>'u', 'û'=>'u', 'ý'=>'y', 'þ'=>'b', 'ÿ'=>'y' );
$amazonUrl = strtr( $amazonUrl, $unwanted_array );
$productId = getProductIdByUrl($amazonUrl);
if($productId == null) {
	$product = parseProduct($amazonUrl);
	if($product == null) {
    	echo '{"exception":"An error occurred while parsing the product"}';
    	exit();
    }
	$productId = insertProductByObject($product, $amazonUrl);
	if($productId == null){
    	echo '{"exception":"An error occurred while adding the product"}';
    	exit();
    }
}

if(addTracking($userId,$productId, $dropValue, $dropKey, $commentPolicy)){
	echo '{"success":"Added and tracked", "productId":'.$productId.'}';
} else {
	echo '{"exception":"Product added but not set as tracked"}';
}

?>