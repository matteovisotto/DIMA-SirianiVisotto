<?php
include '/var/aptracker/_autoload_.php';
/*
$curr = json_decode(file_get_contents(HOME_DIR."data/finalFile.json"), true);

$sql = "INSERT INTO currency (code, name, symbol, localizedSymbol, countryCode, countryName, tld) VALUES (?,?,?,?,?,?,?)";
$db = getDatabaseConnection();
$stmt = $db->prepare($sql);
$code = "";
$name = "";
$symbol = "";
$localizedSymbol = "";
$countryCode = "";
$countryName = "";
$tld = "";
$stmt->bind_param("sssssss", $code, $name, $symbol, $localizedSymbol, $countryCode, $countryName, $tld);

foreach ($curr as $c) {
	$code = $c['Code'];
$name = $c['Name'];
$symbol = $c['Symbol'];
$localizedSymbol = $c['LocalizedSymbol'];
$countryCode = $c['CountryCode'];
$countryName = $c['DisplayName'];
$tld = $c['TLD'];
$stmt->execute();
echo "OK ".$c['Code'].'<br/>';
}

$stmt->close();
*/