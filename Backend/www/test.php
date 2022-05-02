<?php
include '/var/aptracker/_autoload_.php';

$tokens = checkForPriceNotification(33, 1);
$product = getProductById(33);
sendProductNotification($tokens, $product['name'], 33);

?>