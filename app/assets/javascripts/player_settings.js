$(document).ready( function() {
	//da whole thang
	$('.account-creation-container').on('click', '.signup-button', function() {
		var current_section = parseInt($(this).attr('id').split('-')[1], 10);
		var next_section = current_section + 1;
		$('#section-' + current_section ).fadeOut();
		$('#section-' + next_section ).fadeIn();
		$('#badge-' + next_section).addClass('active');
		$('#title-' + next_section).addClass('active');
	});

	$('.tabs').on('click', function() {
    $('.tabs').removeClass('active');
    $(this).addClass('active');
    $('.settings').hide();
    value = $(this).attr('id');
    $('#' + value + '-settings-modal').show();
  });

	// availability selection
	$('.account-creation-container').on('click', '.select-cell', function() {
		$('.submit-availability').removeClass('disabled')
		$(this).toggleClass('checked');
		$(this).children().toggleClass('checked');
		$(this).children().toggleClass('fa-circle-thin');
		$(this).children().toggleClass('fa-check-circle');

		var from = $(this).data('from');
		var to = $(this).data('to');

		var id_array = $(this).attr("id").split('_');
		id_array.pop();
		var id = id_array.join('_');
		var from_field = $('#' + id + '_from');
		var to_field = $('#' + id + '_to');

		if (from_field.val().length > 1) {
			from_field.val('');
		} else {
			from_field.val(from);
		};

		if (to_field.val().length > 1) {
			to_field.val('');
		} else {
			to_field.val(to);
		};
	});

	//sports selection
	$('.account-creation-container').on('click', '.star', function() {
		level = $(this).data('level')
		sport = $(this).data('sport')
		$('#icon_' + sport).addClass('playing');
		$(this).children().addClass('full fa-star')
		$(this).children().removeClass('fa-star-o')
		$(this).prevAll().children().addClass('full fa-star')
		$(this).prevAll().children().removeClass('fa-star-o')
		$(this).nextAll().children().addClass('fa-star-o')
		$(this).nextAll().children().removeClass('fa-star full')
		$('.' + sport).val(level)
		$('.submit-ratings').removeClass('disabled')
	});

	$('.account-creation-container').on('click', '.play_coed', function() {
		$(this).toggleClass('fa-circle-thin');
		$(this).toggleClass('fa-check-circle');
		var sport = $(this).attr('id');
		var checked = $('.' + sport).is(':not(:checked)');
		$('.' + sport).attr('checked', checked);
	});

	$('.account-creation-container').on('click', '.remove_sport', function() {
		var sport_arr = $(this).attr('id').split('_');
		sport_arr.shift();
		var sport = sport_arr.join('_');
		console.log(sport)
		$('.star_' + sport).removeClass('fa-star full');
		$('.star_' + sport).addClass('fa-star-o');
		$('.' + sport).val('');
		$('#icon_' + sport).removeClass('playing');
		$('.coed_' + sport).prop('checked', false);
		$('#coed_' + sport).toggleClass('fa-circle-thin');
		$('#coed_' + sport).toggleClass('fa-check-circle');
	});
});