<?php
/**
	 * #Method: POST
	 * #RequireAuth: true
	 * #Description: Send a broadcast notification. THIS OPERATION IS ALLOWED ONLY TO ADMINISTRATORS
	 * #Parameters: String title - Notification title, String message - Content of the notification, String adminKey - Administrator API Key
	 * #Prameters in: body
	 **/
$adminKey = "m+!8{t6brd;N#9P>XP^!J8Kj8A]auF.&";

if(!isset($_POST['adminKey']) || empty($_POST['adminKey']) || $_POST['adminKey'] != $adminKey){
	header("HTTP/1.1 401 - Unauthorized");
	exit();
}

if(!isset($_POST['title']) || empty($_POST['title']) || !isset($_POST['message']) || empty($_POST['message'])){
	header("HTTP/1.1 400 - Bad request");
	exit();
}

$title = $_POST['title'];
$message = $_POST['message'];

$title_it = isset($_POST['title_it']) ? $_POST['title_it'] : $title;
$message_it = isset($_POST['message_it']) ? $_POST['message_it'] : $message;

$tokens = getAllNotificationTokens();

$url = 'https://fcm.googleapis.com/fcm/send';
 
        //building headers for the request
        $headers = array(
            'Authorization: key=AAAAEC5gQj4:APA91bHN4-EtPFnG0XtyRDcwlpI99w1K3OPbVkqvy40nJrvDq4b-Mlmmj5RVa36T5HDHfazYU6dv3KvKGHtTjKuI-9y92RMpH6D5EA29qbB_Ji6XdM01yUu-9TnBpZWWvjTJpBNIXvjs',
            'Content-Type: application/json'
        );

$fields = array(
			'registration_ids' => $tokens,
            'notification' => array(
        	"title"=> $title,
     		"body"=> $message,
     		"sound"=> "default",
        	"badge" => 1,
    		"mutable_content" => true
     	),
		'data' => array(
            "type"=>"generic",
        	"lang" => array(
            	"en" => array(
                	"title"=>$title,
                	"body" => $message
                ),
            	"it" => array(
                	"title"=> $title_it,
                	"body" => $message_it
                ),
            )
         )
        );
 
        //Initializing curl to open a connection
        $ch = curl_init();
 
        //Setting the curl url
        curl_setopt($ch, CURLOPT_URL, $url);
        
        //setting the method as post
        curl_setopt($ch, CURLOPT_POST, true);
 
        //adding headers 
        curl_setopt($ch, CURLOPT_HTTPHEADER, $headers);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
 
        //disabling ssl support
        curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
        
        //adding the fields in json format 
        curl_setopt($ch, CURLOPT_POSTFIELDS, json_encode($fields));
 
        //finally executing the curl request 
        $result = curl_exec($ch);
        if ($result === FALSE) {
            die('Curl failed: ' . curl_error($ch));
        }
 		echo $result;
        //Now close the connection
        curl_close($ch);
