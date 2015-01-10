$(document).ready( function() {
	function getUrlParameter(sParam) {
    var sPageURL = window.location.search.substring(1);
    var sURLVariables = sPageURL.split('&');
    for (var i = 0; i < sURLVariables.length; i++) {
      var sParameterName = sURLVariables[i].split('=');

      if (sParameterName[0] == sParam) {
        return sParameterName[1];
      };
    };
	};

	var feedback = getUrlParameter('feedback')
	var user = getUrlParameter('user')

	if (feedback === 'true') {
		$('.feedback-modal-state').prop('checked', true);

		$.get('/players/' + user + '/feedbacks/new', function(response) {
			$('.feedback-body').html(response);
		});
	};

	$('.content').on('change', '.initial-rating', function() {
		container = $(this).parent()
		if (container.find('input[type=radio]:checked').val() == 'no') {
			container.find('.player_feedback_form').fadeIn();
			container.find('.all-good-button').hide();
		} else {
			container.find('.all-good-button').fadeIn();
			container.find('.player_feedback_form').hide();
		}
	});

	$('.feedback-body').on('click', '.star', function() {
		level = $(this).data('level')
		sport = $(this).data('sport')
		$(this).children().addClass('full fa-star')
		$(this).children().removeClass('fa-star-o')
		$(this).prevAll().children().addClass('full fa-star')
		$(this).prevAll().children().removeClass('fa-star-o')
		$(this).nextAll().children().addClass('fa-star-o')
		$(this).nextAll().children().removeClass('fa-star full')
		$('.' + sport).val(level)
		$('.submit-ratings').removeClass('disabled')
	});  
});