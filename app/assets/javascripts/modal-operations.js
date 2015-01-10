$(document).ready( function() {
	//adding payment link
	$('.sub-modal').on('click','.add-payment-link', function() {
		$('.sub-modal-state').prop('checked', false);
		$('.settings-modal-state').prop('checked', true);
		var sub_request = $(this).data('request');
		$('#sub_request_return').val(sub_request)
		$('#payment').click();
	});

	//add sport
	$('.sub-modal').on('click', '.add-sport-link', function() {
		$('.sub-modal-state').prop('checked', false);
		$('.settings-modal-state').prop('checked', true);
		$('#sports').click();
	});

	//close settings modal when cancel
	$('.settings-cancel').on('click', function() {
		$('.settings-modal-state').prop('checked', false);
	});
});