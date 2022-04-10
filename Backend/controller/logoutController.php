<?php
	$userId = apiLogin($_POST);
	logout($userId, $_POST['token']);
	echo '{"success":"Logged out"}';