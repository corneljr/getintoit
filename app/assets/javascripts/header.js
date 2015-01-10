// $(document).ready(function(){
//   $("#mobile-dropdown").click(function(){
//     $(".menu").toggleClass("show-menu");
//     $(".menu > li").click(function(){
//       $("#mobile-dropdown").html($(this).html());
//       $(".menu").removeClass("show-menu");
//     });
//   });  
// });

$(document).ready( function() {
	$('.settings-link').on('click', function() {
		$('.settings-modal-state').prop('checked', true);
	});

	$('.sub-modal-close').on('click', function() {
		$('.sub-modal-state').prop('checked', false);
	});

	$('.details-modal-close').on('click', function() {
		$('.details-modal-state').prop('checked', false);
	});	

  $('#mobile-dropdown').click( function() {
    if ($('.nav-overlay').css('visibility') == 'hidden') {
      $('.nav-overlay').css('visibility','visible');
    } else {
      $('.nav-overlay').css('visibility','hidden');
    };
  });

  $('.nav-item-container').click( function() {
    $('.nav-item-container').removeClass('active');
    $('.arrow-down').removeClass('active');
    $(this).addClass('active');
    $(this).find('.arrow-down').addClass('active');
  });

  var tabSelect = function() {
    section = window.location.pathname
    $('.nav-item-container').removeClass('active');
    $('.arrow-down').removeClass('active');

    if (section.match(/^\/sub_requests$/)) {
      $('#openings-nav').addClass('active');
      $('#openings-nav').find('.arrow-down').addClass('active');
    } else if (section.match(/^\/players/)) {
      $('#games-nav').addClass('active');
      $('#games-nav').find('.arrow-down').addClass('active');
    } else if (section.match(/^\/sub_requests\/new$/)) {
      $('#find-nav').addClass('active');
      $('#find-nav').find('.arrow-down').addClass('active');
    };
  }

  tabSelect();

});