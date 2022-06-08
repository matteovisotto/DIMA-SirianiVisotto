<?php

include '/var/aptracker/_autoload_.php';
use MatteoVisotto\Route;
include HOME_DIR.'lib/Route.php';

define('BASEPATH', '/');

session_start();

Route::get("/", function(){
   echo "<h1>aptracker.matmacsystem.it - Operativo</h1>";
});

Route::get("/docs", function(){
	include HOME_DIR."docs.php";
});

Route::get("/admin/notification/broadcast", function(){
	include HOME_DIR."broadcastNotification.php";
});
	
Route::get("/privacyPolicy", function(){
	include HOME_DIR."policy.php";
});

Route::post("/register", function(){
	header('Content-type: application/json');
	include HOME_DIR."controller/registerController.php";
});

Route::post("/auth/login", function(){
	header('Content-type: application/json');
	include HOME_DIR."controller/loginController.php";
});

Route::add("/auth/social/([A-Z-a-z-0-9-]*)", function($social){
	header('Content-type: application/json');
	if(!file_exists(HOME_DIR."controller/social/".$social.".php")){
        echo '{"exception":"Invalid login endpoint"}';
        exit();
    }
	include HOME_DIR."controller/social/".$social.".php";
},["get", "post"]);

Route::post("/auth/refresh", function(){
	header('Content-type: application/json');
	include HOME_DIR."controller/refreshController.php";
});

Route::post("/auth/logout", function(){
	header('Content-type: application/json');
	include HOME_DIR."controller/logoutController.php";
});

Route::add("/api/([A-Z-a-z-0-9-]*)/([A-Z-a-z-0-9-]*)", function($module, $function){
	header('Content-type: application/json');
	if(!file_exists(HOME_DIR."controller/api/".$module."/".$function.".php")){
        echo '{"exception":"Invalid API"}';
        exit();
    }
	include HOME_DIR."controller/api/".$module."/".$function.".php";
},["get", "post"]);

Route::add("/api/v1/([A-Z-a-z-0-9-]*)/([A-Z-a-z-0-9-]*)", function($module, $function){
	header('Content-type: application/json');
	if(!file_exists(HOME_DIR."controller/api/".$module."/".$function.".php")){
        echo '{"exception":"Invalid API"}';
        exit();
    }
	include HOME_DIR."controller/api/".$module."/".$function.".php";
},["get", "post"]);

Route::methodNotAllowed(function ($path, $method) {
    header('HTTP/1.0 405 Method Not Allowed');
    echo "<h1>405 - Method not allowed</h1>";
});

Route::pathNotFound(function ($path) {
    header('HTTP/1.0 404 Not Found');
	if(str_contains($path, '/api/')){
    	echo '{"exception":"API Path not found"}';
    } else {
    	echo '404 - Path not found';
    }
});

Route::run(BASEPATH);

?>