/*
* Kindle DSE App
* http://sestevezg.com
*
*/


function search(){
	searchTerm = $("#search").val()

	$(".centerDiv").css("display","block");
		

	if (!searchTerm==""){
	myAjaxCall = $.ajax({
		 url: "http://localhost:8983/solr/kindle.highlights/select?q=*%3A*&fq=highlight%3A"+searchTerm+"&wt=json&indent=true",
		context: document.body,
		
		type: "POST", 
        contentType: "application/json; charset=utf-8", 
        dataType: 'jsonp', 
        crossDomain: true, 
        jsonp: 'json.wrf' 
	}).done(function(data) {
	
		stringData = JSON.stringify(data.response.docs);
		
		$("#loadStatus").empty();
		
		$("#loadStatus").append('<table></table>');
		var table_obj = $("#loadStatus table");
		
		//header
		table_obj.html('<tr id="0"><th><b>Title</b></th><th><b>Author<b></th><th><b>Highlight</b></th></tr>');
		
		
		$.each(data.response.docs, function(index, item){
			 var table_row = $('<tr>', {id: item.id});
			 var table_cell = $('<td>', {html: item.title});
			 table_row.append(table_cell);
			 table_cell = $('<td>', {html: item.author});
			 table_row.append(table_cell);
			 table_cell = $('<td>', {html: item.highlight});
			 table_row.append(table_cell);
			 table_obj.append(table_row);
		})
	
	});
	
	
	}else{
	
		$("#loadStatus").html("Value Required.");
		
	}

		
}

function loadHighlights(){
	userName = $("#user").val();
	password = $("#password").val();

	$(".centerDiv").css("display","block");
	$("#loadStatus").html("Loading DSE...");
	


	myAjaxCall = $.ajax({
		 url: "loadhighlights.php?user="+userName+"&password="+password,
		context: document.body
	}).done(function(data) {
	
		$("#loadStatus").html(data);
	
	});

}
