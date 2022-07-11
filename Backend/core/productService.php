<?php

function productIdExists($productId){
	$sql = "SELECT 1 FROM product WHERE id = ?";
	$db = getDatabaseConnection();
	$stmt = $db->prepare($sql);
	$stmt->bind_param("i", $productId);
	$stmt->execute();
	$result = $stmt->get_result();
	$stmt->close();
	if($result->num_rows == 0){
    	return false;
    }
	return true;
}

function getProductIdByUrl($amazonUrl){
	$sql = "SELECT * FROM product WHERE link = ?";
	$db = getDatabaseConnection();
	$stmt = $db->prepare($sql);
	$stmt->bind_param("s", $amazonUrl);
	$stmt->execute();
	$result = $stmt->get_result();
	$stmt->close();
	if($result->num_rows == 0){
    	return null;
    }
	$row = $result->fetch_assoc();
	return $row['id'];
}

function getProductByUrl($amazonUrl){
	$sql = "SELECT * FROM product WHERE link = ?";
	$db = getDatabaseConnection();
	$stmt = $db->prepare($sql);
	$stmt->bind_param("s", $amazonUrl);
	$stmt->execute();
	$result = $stmt->get_result();
	$stmt->close();
	if($result->num_rows == 0){
    	return null;
    }
	$row = $result->fetch_assoc();
	return $row;
}

function getProductById($productId){
	$sql = "SELECT * FROM product WHERE id = ?";
	$db = getDatabaseConnection();
	$stmt = $db->prepare($sql);
	$stmt->bind_param("s", $productId);
	$stmt->execute();
	$result = $stmt->get_result();
	$stmt->close();
	if($result->num_rows == 0){
    	return null;
    }
	$row = $result->fetch_assoc();
	return $row;
}

function parseProduct($url) {
	$json_str = shell_exec('cd /var/aptracker/scraper/ && sudo ./Scraper '.$url);
	$obj = json_decode($json_str);
	if(isset($obj->exception)){
    	return null;
    }
	//$obj->price = number_format(floatval($obj->price), 2, '.', '');
	return $obj;
}

function decideForShortName($name, $shortName) {
	if(strlen($name) > 60) {
    	if(strlen($shortName) > 5) {
        	return $shortName;
        }
    }
	
	return $name;
}

function insertProductByObject($obj, $url){
	$sql1 = "INSERT INTO product (link, name, description, shortName, category) VALUES (?,?,?,?,?)";
	$sql2 = "INSERT INTO image (productId, url) VALUES (?,?)";
	$sql3 = "INSERT INTO price (productId, price) VALUES (?,?)";
	$db = getDatabaseConnection();
	$db->begin_transaction();
	try{
    	$stmt1 = $db->prepare($sql1);
    	$shortName = ucfirst(strtolower(decideForShortName($obj->name, str_replace("-", " ", explode("/", str_replace("https://www.amazon.it/", "", $url))[0]))));
    	$name = ucfirst(strtolower($obj->name));
    	$stmt1->bind_param("sssss", $url, $name, $obj->description, $shortName, $obj->category);
    	if(!$stmt1->execute()){
       		$db->rollback();
        	return null;
        }
    	$productId = $stmt1->insert_id;
    	$imageUrl = "";
    	$stmt2 = $db->prepare($sql2);
    	$stmt2->bind_param("is", $productId, $imageUrl);
    	foreach(array_unique($obj->images) as $i){
        	$imageUrl = $i;
        	if(!$stmt2->execute()){
       			$db->rollback();
        		return null;
        	}
        }
    	$price = str_replace("€", "", $obj->price);
    	if($price == 0 || empty($price)){
        	$db->rollback();
        	return null;
        }
    	$stmt3 = $db->prepare($sql3);
    	$stmt3->bind_param("id", $productId, $price);
    	if(!$stmt3->execute()){
       		$db->rollback();
        	return null;
        }
    	$stmt1->close();
    	$stmt2->close();
    	$stmt3->close();
    	$db->commit();
    	return $productId;
    } catch(mysqli_sql_exception $exception) {
    	$db->rollback();
    	return null;
    }
	
}

function getAllProducts() {
	$sql = "SELECT * FROM product";
	$db = getDatabaseConnection();
	$result = $db->query($sql);
	$r = array();
	while($row = $result->fetch_assoc()){
    	$row['prices'] = getProductPricesByProductId($row['id']);
    	$row['images'] = getProductImagesByProductId($row['id']);
    	$row['lowestPrice'] = doubleval($row['lowestPrice']);
    	$row['highestPrice'] = doubleval($row['highestPrice']);	
    	$row['id'] = intval($row['id']);
    	$r[] = $row;
    }
	return $r;
}

function getAllProductsPaging($page, $limit) {
	$sql = "SELECT p.id, p.name, p.shortName, p.category, p.link, p.description, a.price, p.highestPrice, p.lowestPrice, a.updatedAt AS lastUpdate FROM product AS p JOIN price AS a ON p.id = a.productId WHERE a.updatedAt = (SELECT MAX(p2.updatedAt) FROM price AS p2 WHERE a.productId = p2.productId) ORDER BY p.name ASC LIMIT ?,?";
	$db = getDatabaseConnection();
	$stmt = $db->prepare($sql);
	$lower_bound = $limit * $page;
    $higher_bound = $limit * ($page + 1);
	$stmt->bind_param("ii", $lower_bound, $higher_bound);
	$stmt->execute();
	$result = $stmt->get_result();
	$stmt->close();

	$r = array();
	while($row = $result->fetch_assoc()){
    	$row['images'] = getProductImagesByProductId($row['id']);
    	$row['id'] = intval($row['id']);
    	$row['price'] = doubleval($row['price']);
    	$row['lowestPrice'] = doubleval($row['lowestPrice']);
    	$row['highestPrice'] = doubleval($row['highestPrice']);
    	$r[] = $row;
    }
	return $r;
}

function getAllProductsLastPrice() {
	//$sql="SELECT p.id, p.name, p.link, p.description, a.price, MAX(a.updatedAt) AS lastUpdate FROM product AS p JOIN price AS a ON p.id = a.productId GROUP BY a.productId";
	$sql="SELECT p.id, p.name, p.shortName, p.category, p.link, p.description, a.price, p.highestPrice, p.lowestPrice, a.updatedAt AS lastUpdate FROM product AS p JOIN price AS a ON p.id = a.productId WHERE a.updatedAt = (SELECT MAX(p2.updatedAt) FROM price AS p2 WHERE a.productId = p2.productId)";
	$db = getDatabaseConnection();
	$result = $db->query($sql);
	$r = array();
	while($row = $result->fetch_assoc()){
    	$row['images'] = getProductImagesByProductId($row['id']);
    	$row['id'] = intval($row['id']);
    	$row['price'] = doubleval($row['price']);
    	$row['lowestPrice'] = doubleval($row['lowestPrice']);
    	$row['highestPrice'] = doubleval($row['highestPrice']);
    	$r[] = $row;
    }
	return $r;
}

function getMostTracked($limit){
	//$sql="SELECT p.id, p.name, p.link, p.description, a.price, MAX(a.updatedAt) AS lastUpdate FROM product AS p JOIN price AS a ON p.id = a.productId JOIN numberOfTrackers AS n ON n.productId=p.id GROUP BY a.productId ORDER BY n.nTrackers DESC LIMIT ?";
	$sql="SELECT p.id, p.name, p.shortName, p.category, p.link, p.description, a.price, p.highestPrice, p.lowestPrice, a.updatedAt AS lastUpdate, l.priceDrop, l.priceDropPercentage FROM product AS p JOIN price AS a ON p.id = a.productId JOIN numberOfTrackers AS n ON n.productId=p.id JOIN lastPriceDrop AS l ON l.productId = p.id WHERE a.updatedAt=(SELECT MAX(p2.updatedAt) FROM price AS p2 WHERE a.productId = p2.productId) ORDER BY n.nTrackers DESC LIMIT ?";
	$db = getDatabaseConnection();
	$stmt = $db->prepare($sql);
	$stmt->bind_param("i", $limit);
	$stmt->execute();
	$result = $stmt->get_result();
	$stmt->close();
	$r = array();
	while($row = $result->fetch_assoc()){
    	$row['images'] = getProductImagesByProductId($row['id']);
    	$r[] = $row;
    }
	return $r;
}

function getMostTrackedPaging($limit, $page){
	$db = getDatabaseConnection();
	if ($page == -1){
    	$sql="SELECT p.id, p.name, p.shortName, p.category, p.link, p.description, a.price, p.highestPrice, p.lowestPrice, a.updatedAt AS lastUpdate FROM product AS p JOIN price AS a ON p.id = a.productId JOIN numberOfTrackers AS n ON n.productId=p.id WHERE a.updatedAt=(SELECT MAX(p2.updatedAt) FROM price AS p2 WHERE a.productId = p2.productId) ORDER BY n.nTrackers DESC LIMIT ?";
		$stmt = $db->prepare($sql);
		$stmt->bind_param("i", $limit);
    } else {
    	$sql="SELECT p.id, p.name, p.shortName, p.category, p.link, p.description, a.price, p.highestPrice, p.lowestPrice, a.updatedAt AS lastUpdate FROM product AS p JOIN price AS a ON p.id = a.productId JOIN numberOfTrackers AS n ON n.productId=p.id WHERE a.updatedAt=(SELECT MAX(p2.updatedAt) FROM price AS p2 WHERE a.productId = p2.productId) ORDER BY n.nTrackers DESC LIMIT ?,?";
		$stmt = $db->prepare($sql);
		$lower_bound = $limit * $page;
    	$higher_bound = $limit * ($page + 1);
		$stmt->bind_param("ii", $lower_bound, $higher_bound);
    }
	$stmt->execute();
	$result = $stmt->get_result();
	$stmt->close();
	$r = array();
	while($row = $result->fetch_assoc()){
    	$row['images'] = getProductImagesByProductId($row['id']);
    	$r[] = $row;
    }
	return $r;
}

function getByLastPriceDropLimit($limit, $orderByPercentage=false){
	$sql = "SELECT p.id, p.name, p.shortName, p.category, p.link, p.description, p.highestPrice, p.lowestPrice, p.lastUpdate, a.lastPrice AS price, a.priceDrop, a.priceDropPercentage FROM product AS p JOIN lastPriceDrop AS a ON p.id=a.productId ORDER BY a.priceDrop ASC LIMIT ?";
	if($orderByPercentage){
    	$sql = "SELECT p.id, p.name, p.shortName, p.category, p.link, p.description, p.highestPrice, p.lowestPrice, p.lastUpdate, a.lastPrice AS price, a.priceDrop, a.priceDropPercentage FROM product AS p JOIN lastPriceDrop AS a ON p.id=a.productId ORDER BY a.priceDropPercentage ASC LIMIT ?";
    }
	$db = getDatabaseConnection();
	$stmt = $db->prepare($sql);
	$stmt->bind_param("i", $limit);
	$stmt->execute();
	$result = $stmt->get_result();
	$stmt->close();
	$r = array();
	while($row = $result->fetch_assoc()){
    	$row['images'] = getProductImagesByProductId($row['id']);
    	$r[] = $row;
    }
	return $r;
}

function getByLastPriceDropLimitAllPrices($limit, $orderByPercentage=false){
	$sql = "SELECT p.id, p.name, p.shortName, p.cagegory, p.link, p.description, p.highestPrice, p.lowestPrice, p.lastUpdate, a.lastPrice AS price, a.priceDrop, a.priceDropPercentage FROM product AS p JOIN lastPriceDrop AS a ON p.id=a.productId ORDER BY a.priceDrop ASC LIMIT ?";
	if($orderByPercentage){
    	$sql = "SELECT p.id, p.name, p.shortName, p.category, p.link, p.description, p.highestPrice, p.lowestPrice, p.lastUpdate, a.lastPrice AS price, a.priceDrop, a.priceDropPercentage FROM product AS p JOIN lastPriceDrop AS a ON p.id=a.productId ORDER BY a.priceDropPercentage ASC LIMIT ?";
    }
	$db = getDatabaseConnection();
	$stmt = $db->prepare($sql);
	$stmt->bind_param("i", $limit);
	$stmt->execute();
	$result = $stmt->get_result();
	$stmt->close();
	$r = array();
	while($row = $result->fetch_assoc()){
    	$row['prices'] = getProductPricesByProductId($row['id']);
    	$row['images'] = getProductImagesByProductId($row['id']);
    	$r[] = $row;
    }
	return $r;
}

function getByLastPriceDropLimitPaging($limit, $page, $orderByPercentage=false){
	$db = getDatabaseConnection();
	if($orderByPercentage){
    	$sql = "SELECT p.id, p.name, p.shortName, p.category, p.link, p.description, p.highestPrice, p.lowestPrice, p.lastUpdate, a.lastPrice AS price, a.priceDrop, a.priceDropPercentage FROM product AS p JOIN lastPriceDrop AS a ON p.id=a.productId ORDER BY a.priceDropPercentage ASC LIMIT ?,?";
    	$stmt = $db->prepare($sql);
		$lower_bound = $limit * $page;
    	$higher_bound = $limit * ($page + 1);
		$stmt->bind_param("ii", $lower_bound, $higher_bound);
    } else {
    	$sql = "SELECT p.id, p.name, p.shortName, p.category, p.link, p.description, p.highestPrice, p.lowestPrice, p.lastUpdate, a.lastPrice AS price, a.priceDrop, a.priceDropPercentage FROM product AS p JOIN lastPriceDrop AS a ON p.id=a.productId ORDER BY a.priceDrop ASC LIMIT ?";
		$stmt = $db->prepare($sql);
		$stmt->bind_param("i", $limit);
    }
	$stmt->execute();
	$result = $stmt->get_result();
	$stmt->close();
	$r = array();
	while($row = $result->fetch_assoc()){
    	$row['images'] = getProductImagesByProductId($row['id']);
    	$r[] = $row;
    }
	return $r;
}

function getByLastPriceDrop($orderByPercentage=false){
	$sql = "SELECT p.id, p.name, p.shortName, p.category, p.link, p.description, p.highestPrice, p.lowestPrice, p.lastUpdate, a.lastPrice AS price, a.priceDrop, a.priceDropPercentage FROM product AS p JOIN lastPriceDrop AS a ON p.id=a.productId ORDER BY a.priceDrop ASC";
	if($orderByPercentage){
    	$sql = "SELECT p.id, p.name, p.shortName, p.category, p.link, p.description, p.highestPrice, p.lowestPrice, p.lastUpdate, a.lastPrice AS price, a.priceDrop, a.priceDropPercentage FROM product AS p JOIN lastPriceDrop AS a ON p.id=a.productId ORDER BY a.priceDropPercentage ASC";
    }
	$db = getDatabaseConnection();
	$stmt = $db->prepare($sql);
	$stmt->execute();
	$result = $stmt->get_result();
	$stmt->close();
	$r = array();
	while($row = $result->fetch_assoc()){
    	$row['images'] = getProductImagesByProductId($row['id']);
    	$r[] = $row;
    }
	return $r;
}

function getByLastPriceDropAllPrices($orderByPercentage=false){
	$sql = "SELECT p.id, p.name, p.shortName, p.category, p.link, p.description, p.highestPrice, p.lowestPrice, p.lastUpdate, a.lastPrice AS price, a.priceDrop, a.priceDropPercentage FROM product AS p JOIN lastPriceDrop AS a ON p.id=a.productId ORDER BY a.priceDrop ASC";
	if($orderByPercentage){
    	$sql = "SELECT p.id, p.name, p.shortName, p.category, p.link, p.description, p.highestPrice, p.lowestPrice, p.lastUpdate, a.lastPrice AS price, a.priceDrop, a.priceDropPercentage FROM product AS p JOIN lastPriceDrop AS a ON p.id=a.productId ORDER BY a.priceDropPercentage ASC";
    }
	$db = getDatabaseConnection();
	$stmt = $db->prepare($sql);
	$stmt->execute();
	$result = $stmt->get_result();
	$stmt->close();
	$r = array();
	while($row = $result->fetch_assoc()){
    	$row['prices'] = getProductPricesByProductId($row['id']);
    	$row['images'] = getProductImagesByProductId($row['id']);
    	$r[] = $row;
    }
	return $r;
}

function getByPriceDropLimit($limit, $orderByPercentage=false){
	$sql = "SELECT p.id, p.name, p.shortName, p.category, p.link, p.description, p.highestPrice, p.lowestPrice, p.lastUpdate, a.lastPrice AS price, a.priceDrop, a.priceDropPercentage FROM product AS p JOIN priceDrop AS a ON p.id=a.productId ORDER BY a.priceDrop ASC LIMIT ?";
	if($orderByPercentage){
    	$sql = "SELECT p.id, p.name, p.shortName, p.category, p.link, p.description, p.highestPrice, p.lowestPrice, p.lastUpdate, a.lastPrice AS price, a.priceDrop, a.priceDropPercentage FROM product AS p JOIN priceDrop AS a ON p.id=a.productId ORDER BY a.priceDropPercentage ASC LIMIT ?";
    }
	$db = getDatabaseConnection();
	$stmt = $db->prepare($sql);
	$stmt->bind_param("i", $limit);
	$stmt->execute();
	$result = $stmt->get_result();
	$stmt->close();
	$r = array();
	while($row = $result->fetch_assoc()){
    	$row['images'] = getProductImagesByProductId($row['id']);
    	$r[] = $row;
    }
	return $r;
}

function getByPriceDropLimitPaging($limit, $page, $orderByPercentage=false){
	$db = getDatabaseConnection();
	if($orderByPercentage){
    	$sql = "SELECT p.id, p.name, p.shortName, p.category, p.link, p.description, p.highestPrice, p.lowestPrice, p.lastUpdate, a.lastPrice AS price, a.priceDrop, a.priceDropPercentage FROM product AS p JOIN priceDrop AS a ON p.id=a.productId ORDER BY a.priceDropPercentage ASC LIMIT ?";
    	$stmt = $db->prepare($sql);
    	$stmt->bind_param("i", $limit);
    } else {
		$sql = "SELECT p.id, p.name, p.shortName, p.category, p.link, p.description, p.highestPrice, p.lowestPrice, p.lastUpdate, a.lastPrice AS price, a.priceDrop, a.priceDropPercentage FROM product AS p JOIN priceDrop AS a ON p.id=a.productId ORDER BY a.priceDrop ASC LIMIT ?,?";
		$stmt = $db->prepare($sql);
		$lower_bound = $limit * $page;
    	$higher_bound = $limit * ($page + 1);
		$stmt->bind_param("ii", $lower_bound, $higher_bound);
    }
	$stmt->execute();
	$result = $stmt->get_result();
	$stmt->close();
	$r = array();
	while($row = $result->fetch_assoc()){
    	$row['images'] = getProductImagesByProductId($row['id']);
    	$r[] = $row;
    }
	return $r;
}

function getByPriceDrop($orderByPercentage=false){
	$sql = "SELECT p.id, p.name, p.shortName, p.category, p.link, p.description, p.highestPrice, p.lowestPrice, p.lastUpdate, a.lastPrice AS price, a.priceDrop, a.priceDropPercentage FROM product AS p JOIN priceDrop AS a ON p.id=a.productId ORDER BY a.priceDrop ASC";
	if($orderByPercentage){
    	$sql = "SELECT p.id, p.name, p.shortName, p.category, p.link, p.description, p.highestPrice, p.lowestPrice, p.lastUpdate, a.lastPrice AS price, a.priceDrop, a.priceDropPercentage FROM product AS p JOIN priceDrop AS a ON p.id=a.productId ORDER BY a.priceDropPercentage ASC";
    }
	$db = getDatabaseConnection();
	$stmt = $db->prepare($sql);
	$stmt->execute();
	$result = $stmt->get_result();
	$stmt->close();
	$r = array();
	while($row = $result->fetch_assoc()){
    	$row['images'] = getProductImagesByProductId($row['id']);
    	$r[] = $row;
    }
	return $r;
}

function getCategories(){
	$sql = "SELECT DISTINCT category FROM product ORDER BY category ASC";
	$db = getDatabaseConnection();
	$stmt = $db->prepare($sql);
	$stmt->execute();
	$result = $stmt->get_result();
	$stmt->close();
	$categories = array();
	while ($row = $result->fetch_assoc()){
    	$categories[] = $row['category'];
    }
	$resp = array();
	$resp['categories'] = $categories;
	return $resp;
}

?>