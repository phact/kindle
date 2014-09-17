<?php

$myResponse = "";


if(!($_GET['user'] === null) && !($_GET['password']=== null)) {

##Must be modified based on the location of ruby and the kindle program. Ugly but it works.
	$myResponse = exec("/home/tato/.rbenv/versions/2.1.2/bin/ruby /var/www/html/bin/kindle " . $_GET['user'] . " " . $_GET['password'],$op,$ret_val);
	print $ret_val;
}
else{
	$myResponse = "ERROR: Values Needed";
}


print $myResponse;

?>
