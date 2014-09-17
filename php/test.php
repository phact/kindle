<?php

$myResponse = "";


if(!($_GET['user'] === null) && !($_GET['password']=== null)) {
	$myResponse = exec("/home/tato/Documents/kindle/bin/kindle " . $_GET['user'] . " " . $_GET['password']);
}
else{
	$myResponse = "ERROR: Values Needed";
}


print $myResponse;

?>
