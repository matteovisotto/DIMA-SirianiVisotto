<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>APTracker Broadcast Notification</title>

  <!-- Google Font: Source Sans Pro -->
  <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700&display=fallback">
  <!-- Font Awesome -->
  <link rel="stylesheet" href="/assets/fontawesome/all.min.css">
  <!-- icheck bootstrap -->
  <link rel="stylesheet" href="/assets/icheck/icheck-bootstrap.min.css">
  <!-- Theme style -->
  <link rel="stylesheet" href="/assets/adminlte/adminlte.min.css">
</head>
<body class="hold-transition login-page">
<div class="wrapper w-75">
  <div class="wrapper-content mt-3">
    <h2><strong>APTracker Broadcast notification</strong></h2>
    <p>Use this page to send a broadcast notification if you are an authorized person</p>
    <div class="row">
    <div class="col-12">
    	<form>
    		<div class="row">
    			<div class="col-12 mb-3">
    				<label>Admin API Key</label>
    				<input type="text" placeholder="ADMIN KEY" class="form-control" id="adminKey"/>
    			</div>
    			<div class="col-md-6 col-sm-12">
    				<div class="vstack gap-2">
    					<h5>English</h5>
    					<label>Title</label>
    					<input type="text" placeholder="Title" class="form-control" id="title"/>
    					<label>Message</label>
    					<textarea class="form-control" id="message"></textarea>
    				</div>
    			</div>
    			
    			<div class="col-md-6 col-sm-12">
					<div class="vstack gap-2">
    					<h5>Italiano</h5>
    					<label>Title</label>
    					<input type="text" placeholder="Title" class="form-control" id="it_title"/>
    					<label>Message</label>
    					<textarea class="form-control" id="it_message"></textarea>
    				</div>
    			</div>
    			<div class="col-12 mt-3">
    				<button type="button" class="btn btn-success float-right" id="sendBtn">SEND</button>
  				</div>
    		</div>
    	</form>
    </div>
   
<div class="row mt-3 mb-3">
</div>

</div>
<!-- jQuery -->
<script src="/assets/jquery/jquery.min.js"></script>
<!-- Bootstrap 4 -->
<script src="/asstes/bootstrap/bootstrap.bundle.min.js"></script>
<!-- AdminLTE App -->
<script src="/assets/adminlte/adminlte.min.js"></script>
    <script>
    	$(function(){
        	$('#sendBtn').on('click', function(e){
            	var adminKey = $('#adminKey').val();
            	var title = $('#title').val();
            	var it_title = $('#it_title').val();
            	var message = $('#message').val();
            	var it_message = $('#it_message').val();
            	$.ajax({
        			url:"/api/v1/notification/sendBroadcast",
        			method:"POST", //First change type to method here

        			data:{
                    adminKey: adminKey,
                    title: title,
                    message: message,
                    title_it: it_title,
                    message_it: it_message
                    },
        			success:function(response) {
         				alert("Successfully sent");
       				},
       				error:function(){
        				alert("error");
       				}
            	});
            });
        });
    </script>
</body>
</html>



