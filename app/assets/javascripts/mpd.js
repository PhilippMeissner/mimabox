$(document).ready(function(){
	console.log("ready!");
	$("a.ctrl").click(function(event){
		console.log("check");
		$.post(this,{},function(){
	 		alert("done");      
		});
		event.preventDefault();
		return false;
	});
});
 
