<?php
include '/var/aptracker/_autoload_.php';

echo json_encode(getByPriceDropLimit(2));

/*
$products = getAllProductsLastPrice();

foreach($products as $p) {
	$tokens = checkForPriceNotification($p['id'],floatval($p['price'])-0.01);
	$product = getProductById($p['id']);
	sendProductNotification($tokens, $p['shortName'], $p['id']);
	echo $p['name'].'<br/>';
}
*/
/*
$tokens = checkForPriceNotification(49, 12.66);
$product = getProductById(49);
sendProductNotification($tokens, $product['shortName'], 49);

*/


/*$db = getDatabaseConnection();
$db2 = getDatabaseConnection();
$images = $db2->query("select * from image where url not like '%SR320,320%'");
$stmt = $db->prepare("UPDATE image SET url=? WHERE productId=? AND url=?");
$newUrl = "";
$oldUrl = "";
$id = 0;
$stmt->bind_param("sis", $newUrl, $id, $oldUrl);
foreach($images as $p){
	$id = $p['productId'];
	$oldUrl = $p['url'];
	$newUrl = str_replace("US200", "SR320,320", str_replace("SR38,50", "SR320,320", $p['url']));
	$stmt->execute();
	echo "OK<br/>";
}*/

//writeScraperLog(0, "url a cas0", "ahahahah");
/*
$url = "https://www.amazon.it/Navaris-Tubo-Estensibile-Giardino-irrigazione/dp/B07NGQK8XM?pd_rd_w=oGArK&pf_rd_p=e1a177fc-8da0-4124-b89a-cc372481f442&pf_rd_r=T64D85SDM2PS3DEYK066&pd_rd_r=cc10e204-6f31-4cc6-9d8c-e82d45f0bf35&pd_rd_wg=BYTqB&pd_rd_i=B07NGQK8XM&ref_=pd_bap_d_rp_1_i&th=1";
$json_str = shell_exec('cd /var/aptracker/scraper/ && ./Scraper '.$url);
echo $json_str;
*/
?>