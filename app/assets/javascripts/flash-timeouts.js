$(document).on('ready', function() {
	setTimeout(function(){
    $('.flash-success').fadeOut();
    $('.flash-notice').fadeOut();
    $('.flash-error').fadeOut();
  }, 5000);
});