<?php

function getCurrenciesJSON() {
	$str = file_get_contents(HOME_DIR."data/currencies.json");
	return json_decode($str, true);
}

function getCountryCodesJSON() {
	$str = file_get_contents(HOME_DIR."data/currencies_countrycode.json");
	return json_decode($str, true);
}

function getCodeBySymbol($symbol){
	$json = getCurrenciesJSON();
	$r = array();
	foreach($json as $j){
    	if($j['symbol_native'] == $symbol){
        	$r[] = $j['code'];
        }
    }
	return $r;
}

function getCountryCodeByLocale($locale){
	$json = getCountryCodesJSON();
	foreach($json as $j){
    	if($j['CountryCode'] == $locale){
        	return $j['Code'];
        }
    }
	return null;
}

function getCodeBySymbolAndLocale($symbol, $locale){
	$result = getCodeBySymbol($symbol);
	if(count($result) == 1){
    	return $result[0];
    } else if (count($result) == 0){
    	return null;
    } else {
    	$code = getCountryCodeByLocale($locale);
    	if ($code != null){
        	if(in_array($code, $result)){
            	return $code;
            }
        }
    }
	return null;
}
