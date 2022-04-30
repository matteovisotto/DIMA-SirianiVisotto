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
	return $obj;
}

function insertProductByObject($obj, $url){
	$sql1 = "INSERT INTO product (link, name, description) VALUES (?,?,?)";
	$sql2 = "INSERT INTO image (productId, url) VALUES (?,?)";
	$sql3 = "INSERT INTO price (productId, price) VALUES (?,?)";
	$db = getDatabaseConnection();
	$db->begin_transaction();
	try{
    	$stmt1 = $db->prepare($sql1);
    	$stmt1->bind_param("sss", $url, $obj->name, $obj->description);
    	if(!$stmt1->execute()){
        	echo "Here 1";
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
    	$stmt3 = $db->prepare($sql3);
    	$stmt3->bind_param("id", $productId, $price);
    	if(!$stmt3->execute()){
        	echo "Here 3";
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
    	$r[] = $row;
    }
	return $r;
}

function getAllProductsLastPrice() {
	$sql="SELECT p.id, p.name, p.link, p.description, a.price, MAX(a.updatedAt) AS lastUpdate FROM product AS p JOIN price AS a ON p.id = a.productId GROUP BY a.productId";
	$db = getDatabaseConnection();
	$result = $db->query($sql);
	$r = array();
	while($row = $result->fetch_assoc()){
    	$row['images'] = getProductImagesByProductId($row['id']);
    	$r[] = $row;
    }
	return $r;
}

function getMostTracked($limit){
	$sql="SELECT p.id, p.name, p.link, p.description, a.price, MAX(a.updatedAt) AS lastUpdate FROM product AS p JOIN price AS a ON p.id = a.productId JOIN numberOfTrackers AS n ON n.productId=p.id GROUP BY a.productId ORDER BY n.nTrackers DESC LIMIT ?";
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

?>