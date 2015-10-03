$(document).ready(function(){

	$("a.ctrl").click(function(event){
    _this = this;
		$.post(this, {}, function(response){
      console.log(response);
      if(_this.pathname == '/mpd/pause') {
        update_state(response, _this);
      }
		});
		event.preventDefault();
		return false;
	});

  // If Play/Pause was clicked, update UI
  update_state = function(state, elem) {
    console.log(elem);
    elem.children[0].innerText = state;
    elem.children[0].style.textTransform = "capitalize";
    console.log("Update state called");
  };

  // Play song from current queue
  $("a.play-song-btn").click(function(event) {
    $.post(this, {}, function(response) {
      console.log(response);
    });
    event.preventDefault();
    return false;
  });


  // Remove a song from current queue
  $("a.remove-song-btn").click(function(event) {
    // Save (clicked) html element
    _this = this;
    $.post(this, {}, function(response) {
      // If song was deleted from DB
      if(response) {
        // Remove the row in our UI
        _this.parentNode.parentNode.remove();
      } else {
        console.log("Song was not removed.");
      }
    });
    event.preventDefault();
    return false;
  });
});
