<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>APTracker API Docs</title>

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
    <h2><strong>APTracker API docs</strong></h2>
    <p><i>If the api requires autentication a quary string parameter called <strong>token</strong> must be included with the user personal accessToken</i></p>
    <div class="row">

<?php
$modules = scandir("/var/aptracker/controller/api");

foreach ($modules as $m){
	if(!($m=="." || $m=="..")){
		$apis = scandir("/var/aptracker/controller/api/".$m);
    	echo '<div class="col-12"><h4>'.ucfirst($m).'</h4></div>';
    	foreach($apis as $a){
        	if(!($a=="." || $a=="..")){
            	$tokens = token_get_all(file_get_contents("/var/aptracker/controller/api/".$m."/".$a));
				$comments = array();
				foreach($tokens as $token) {
    				if($token[0] == T_COMMENT || $token[0] == T_DOC_COMMENT) {
       				 $comments[] = str_replace("*", "", str_replace("/", "", $token[1]));
    				}			
				}
				if(count($comments)>0){
					$aDesc = $comments[0];
					$parts = explode("#", $aDesc);
                	$prop = array();
                	foreach($parts as $p){
                    	$e = explode(":", $p);
                    	$prop[str_replace("\n\t ", "", $e[0])] = str_replace("\n\t ", "", $e[1]);
                    }
          
                	$color = str_replace(" ", "", $prop["Method"]) == "POST" ? 'warning' : 'success';
                	$auth = str_replace(" ", "", $prop["RequireAuth"]) == "true" ? '<span class="badge badge-danger">Protected</span>' : '';
                    
          			echo '<div class="col-12">
        <div class="card card-outline card-'.$color.' collapsed-card">
              <div class="card-header">
                <h3 class="card-title"><h3 class="badge badgle-lg badge-'.$color.'">'.$prop["Method"].'</h3>&nbsp;&nbsp;&nbsp;&nbsp;<strong>'.str_replace(".php", "", ucfirst($a)).'</strong>&nbsp;&nbsp;&nbsp;&nbsp;-&nbsp;&nbsp;&nbsp;&nbsp; /api/v1/'.$m.'/'.str_replace(".php", "", $a).'&nbsp;&nbsp;&nbsp;&nbsp&nbsp;&nbsp;&nbsp;&nbsp&nbsp;&nbsp;&nbsp;&nbsp;'.$auth.'</h3>
                <div class="card-tools">
                  <button type="button" class="btn btn-tool" data-card-widget="collapse">
                    <i class="fas fa-plus"></i>
                  </button>
                </div>
                <!-- /.card-tools -->
              </div>
              <!-- /.card-header -->
              <div class="card-body">
                <table class="table table-sm table-striped">
                  <tbody>';
                	unset($prop['Method']);
                	unset($prop[' ']);
                	foreach ($prop as $key => $value){
                    	if($key == "Parameters" || $key == "Optional Parameters"){
                        	$param = explode(",", $value);
                        	echo '<tr><td><strong>'.$key.'</strong></td><td><ul>';
                        	foreach($param as $x){
                            	echo '<li>'.$x.'</li>';
                            }
                        echo '</ul></td></td>';
                        } else {
                    	echo '<tr><td><strong>'.$key.'</strong></td><td>'.$value.'</td></tr>';
                        }
                    }
                echo '</tbody>
                </table>
              </div>
              <!-- /.card-body -->
            </div></div>';
				}
            }
        }
    }
}
?>
<div class="row mt-3 mb-3">
<p><i>API Documentation related to iOS application <strong>APTracker</strong> developed by <strong>Matteo Visotto</strong> and <strong>Mattia Siriani</strong> for Design and Implementation of Mobile Application course at <strong>Politecnico di Milano</strong></i></p>
</div>

</div>
<!-- jQuery -->
<script src="/assets/jquery/jquery.min.js"></script>
<!-- Bootstrap 4 -->
<script src="/asstes/bootstrap/bootstrap.bundle.min.js"></script>
<!-- AdminLTE App -->
<script src="/assets/adminlte/adminlte.min.js"></script>
</body>
</html>


