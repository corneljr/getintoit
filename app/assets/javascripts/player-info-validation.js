$(document).on('ready', function() {
	$('.account-creation-container').on('keyup', '#player_birth_date', function() {
		var dob = $(this).val();
		var match = dob.match(/^\d\d\/\d\d\/\d\d\d\d$/)
		if (match) {
			$(this).removeClass('invalid');
			$(this).addClass('valid');
		} else {
			$(this).removeClass('valid');
			$(this).addClass('invalid');
		};
	});

	$('.account-creation-container').on('keyup', '#player_password', function() {
		if ($(this).val().length > 5) {
			$(this).removeClass('invalid');
			$(this).addClass('valid');
		} else {
			$(this).removeClass('valid');
			$(this).addClass('invalid');
		};
	});

	$('.account-creation-container').on('keyup', '#player_password_confirmation', function() {
		if ($(this).val() == $('#player_password').val()) {
			$(this).removeClass('invalid');
			$(this).addClass('valid');
		} else {
			$(this).removeClass('valid');
			$(this).addClass('invalid');
		};
	});

	$('.account-creation-container').on('keyup', '#player_email', function() {
		var email = $(this).val();
		var match = email.match(/^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/)
		self = $(this)
		if (match) {
			$.get('/check_email?email=' + email, function(data) {
				console.log(data['valid'])
				if (data['valid']) {
					self.removeClass('invalid');
					self.addClass('valid');
				} else {
					self.removeClass('valid');
					self.addClass('invalid');
				};
			});
		} else {
			$(this).removeClass('valid');
			$(this).addClass('invalid');
		};
	});

	$('.account-creation-container').on('keyup', '#player_address', function() {
		if ($(this).val().length > 5) {
			$(this).removeClass('invalid');
			$(this).addClass('valid');
		} else {
			$(this).removeClass('valid');
			$(this).addClass('invalid');
		};
	});
});