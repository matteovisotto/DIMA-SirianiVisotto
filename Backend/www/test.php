<?php
include '/var/aptracker/_autoload_.php';

/*$tokens = checkForPriceNotification(41, 1);
$product = getProductById(41);
sendProductNotification($tokens, $product['name'], 41);*/

/*
$db = getDatabaseConnection();
$products = getAllProducts();
$stmt = $db->prepare("UPDATE product SET name=?, shortName=? WHERE id=?");
$shortName = "";
$name = "";
$id = 0;
$stmt->bind_param("ssi", $name, $shortName, $id);
foreach($products as $p){
	$shortName = ucfirst(strtolower(decideForShortName($p['name'], $p['shortName'])));
    $name = ucfirst(strtolower($p['name']));
	$id = $p['id'];
	$stmt->execute();
	echo "OK<br/>";
}
*/
?>