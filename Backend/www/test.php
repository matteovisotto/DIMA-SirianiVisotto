

<?php
$url = "https://www.amazon.it/Lavazza-Capsule-caffè-Modo-Intenso/dp/B07KGGD8FR";
//parseProduct($url);
$json_str = shell_exec('cd /var/aptracker/scraper/ && ./Scraper '.$url);
	echo $json_str;
//echo json_encode(parseProduct("https://www.amazon.it/Lavazza-Capsule-caffè-Modo-Intenso/dp/B07KGGD8FR"));
?>
