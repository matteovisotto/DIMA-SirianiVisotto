<?php
function updatePrices(){
	$sql = 'SELECT id, link FROM product WHERE lastUpdate < DATE_SUB(NOW(), INTERVAL 5 hour)';
	$sql2 = 'INSERT INTO price (productId, price) values (?, ?)';
	$db = getDatabaseConnection();
	$db2 = getDatabaseConnection();
	$result = $db->query($sql);
	$price = 0;
	$id = 0;
	$stmt = $db2->prepare($sql2);
	$stmt->bind_param('id', $id, $price);
	while ($row = $result->fetch_assoc()) {
	    $url = $row['link'];
	    $id = $row['id'];
	    $json_str = shell_exec('cd /var/aptracker/scraper/ && ./Scraper --price-only '.$url);
	    $obj = json_decode($json_str);
	    $price = str_replace('€', '', $obj->price);
    	if($price == 0 || empty($price)){
        	writeScraperLog(0, $url, 'zero or empty price');
        	continue;
        }
    	writeScraperLog(1, $url, $price);
    	notifyFollowers($id, $price);
	    $stmt->execute();
	}
}

function notifyFollowers($productId, $newPrice) {
	$tokens = checkForPriceNotification($productId, $newPrice);
	$product = getProductById($productId);
	sendProductNotification($tokens, $product['shortName'], $productId);
}


?>