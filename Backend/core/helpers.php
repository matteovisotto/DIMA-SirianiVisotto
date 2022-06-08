<?php

function checkForPriceNotification($productId, $newPrice) {
	$trackers = getAllTrackersWithNotificationByProductId($productId);
	$tokens = array();
	foreach($trackers as $t){
    	$dropKey = $t['dropKey'];
    	if($dropKey == "always") {
        	$tk = getNotificationTokensForAlways($productId, $newPrice, $t);
        	$tokens = array_merge($tokens, $tk);
        } else if($dropKey == "percentage") {
        	$tk = getNotificationTokensForPercentage($productId, $newPrice, $t);
        	$tokens = array_merge($tokens, $tk);
        } else if($dropKey == "value") {
        	$tk = getNotificationTokensForValue($productId, $newPrice, $t);
        	$tokens = array_merge($tokens, $tk);
        }
    }
	return $tokens;
}

function checkForCommentNotification($productId, $userId) {
	$trackers = getAllTrackersWithCommentNotificationByProductId($productId, $userId);
	$tokens = array();
	foreach($trackers as $t){
    	$tk = getNotificationTokenByUserId($t['userId']);
        $tokens = array_merge($tokens, $tk);
    }
	return $tokens;
}

function getNotificationTokensForAlways($productId, $newPrice, $t) {
	$lastPrice = getProductLastPriceByProductId($productId)['price'];
	$tokens = array();
	if(floatval($lastPrice) > floatval($newPrice)) {
    	$tk = getNotificationTokenByUserId($t['userId']);
        $tokens = array_merge($tokens, $tk);
    }
	return $tokens;
}

function getNotificationTokensForPercentage($productId, $newPrice, $t) {
	$trackingSince = $t['trackingSince'];
	$targetPrice = getFirstPriceBeforeDateByProductId($productId, $trackingSince);
	if($targetPrice == null){
    	$targetPrice = getFirstPriceAfterDateByProductId($productId, $trackingSince);
    }
	$tokens = array();
	if($targetPrice != null){
    	$targetPrice = $targetPrice['price'];
        if(((($newPrice-$targetPrice)/$targetPrice)*100) <= -$t['dropValue']) {
        	$tk = getNotificationTokenByUserId($t['userId']);
        	$tokens = array_merge($tokens, $tk);
    	}
    }
	return $tokens;
}

function getNotificationTokensForValue($productId, $newPrice, $t) {
	$trackingSince = $t['trackingSince'];
	$targetPrice = getFirstPriceBeforeDateByProductId($productId, $trackingSince);
	if($targetPrice == null){
    	$targetPrice = getFirstPriceAfterDateByProductId($productId, $trackingSince);
    }
	$tokens = array();
	if($targetPrice != null){
    	$targetPrice = $targetPrice['price'];
		if($newPrice <= $t['dropValue']) {
    		$tk = getNotificationTokenByUserId($t['userId']);
        	$tokens = array_merge($tokens, $tk);
    	}
    }
	return $tokens;
}

function writeScraperLog($type, $url, $price){
		//Write action to txt log
		if($type == 1) {
    		$log  = date("Y-m-d H:i:s")." [SUCCESS] - ProductURL: ".$url." get the price ".$price." €".PHP_EOL;
        } else if($type == 0) {
        	$log  = date("Y-m-d H:i:s")." [WARNING] - ProductURL: ".$url." get a warning for: ".$price.PHP_EOL;
        } else {
        	$log  = date("Y-m-d H:i:s")." [ERROR] - ProductURL: ".$url." get the price ".$price." €".PHP_EOL;
        }
    	//-
    	if(file_exists('/var/aptracker/logs/scraper_log_'.date("j.n.Y").'.txt')){
    		file_put_contents('/var/aptracker/logs/scraper_log_'.date("j.n.Y").'.txt', $log, FILE_APPEND);
        } else {
        	file_put_contents('/var/aptracker/logs/scraper_log_'.date("j.n.Y").'.txt', $log);
        }
}

?>