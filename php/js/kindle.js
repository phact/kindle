/*
* Kindle DSE App
* http://sestevezg.com
*
*/

function loadHighlights(){
	userName = $("#user").val();
	password = $("#password").val();

	$(".centerDiv").css("display","block");
	$("#loadStatus").html("Loading DSE...");
	


	myAjaxCall = $.ajax({
		 url: "test.php?user="+userName+"&password="+password,
		context: document.body
	}).done(function(data) {
	
		$("#loadStatus").html(data);
	
	});

}
