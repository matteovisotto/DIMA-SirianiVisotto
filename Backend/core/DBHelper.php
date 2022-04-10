<?php
function loadMySqlConf() {
	return parse_ini_file(HOME_DIR.'config/mysql.conf');
}

function getDatabaseConnection() {
	$conf = loadMySqlConf();
	 $db = new \mysqli($conf["mysql.host"], $conf["mysql.username"], $conf["mysql.password"], $conf["mysql.dbName"]);
        if ($db->connect_error) {
            return null;
        }
        return $db;
}