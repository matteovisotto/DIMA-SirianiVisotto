<?php
	$userId = apiLogin($_POST);
	$deviceId = $_POST['deviceId'];
	logout($userId, $_POST['token']);
	removeUserFromDeviceById($userId, $deviceId);
	echo '{"success":"Logged out"}';