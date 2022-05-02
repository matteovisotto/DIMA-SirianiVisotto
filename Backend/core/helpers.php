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

function getNotificationTokensForAlways($productId, $newPrice, $t) {
	$lastPrice = getProductLastPriceByProductId($productId)['price'];
	$tokens = array();
	if($lastPrice > $newPrice) {
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
		if(($targetPrice-$newPrice) >= $t['dropValue']) {
    		$tk = getNotificationTokenByUserId($t['userId']);
        	$tokens = array_merge($tokens, $tk);
    	}
    }
	return $tokens;
}

?>