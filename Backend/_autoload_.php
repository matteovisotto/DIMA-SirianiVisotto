<?php
define('HOME_DIR','/var/aptracker/');
include HOME_DIR.'core/currencieService.php';
include HOME_DIR.'core/DBHelper.php';
include HOME_DIR.'core/loginService.php';
include HOME_DIR.'core/userService.php';
include HOME_DIR.'core/commentService.php';
include HOME_DIR.'core/priceService.php';
include HOME_DIR.'core/imageService.php';
include HOME_DIR.'core/productService.php';
include HOME_DIR.'core/trackingService.php';
include HOME_DIR.'core/notificationService.php';
include HOME_DIR.'core/helpers.php';
require_once HOME_DIR.'lib/GoogleAPI/vendor/autoload.php';