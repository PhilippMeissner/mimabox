$(document).ready(function(){
	$("a.ctrl").click(function(event){
		$.post(this, {}, function(){
      console.log("Done.");
		});
		event.preventDefault();
		return false;
	});
});
