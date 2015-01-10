payments = {
	setupForm: function() {
			$('#payment_form').on('submit', function(e){
				e.preventDefault();
				$('input[type=submit]').attr('disabled',true);
				payments.processCard();
			});
	},

	processCard: function() {
		card = {
			number: $('#card_number').val(),
			cvc: $('#card_code').val(),
			expMonth: $('#card_month').val(),
			expYear: $('#card_year').val()
		};

		Stripe.card.createToken(card, payments.stripeResponseHandler);
	},

	stripeResponseHandler: function(status, response) {
		form = $('#payment_form');

		if (response.error) {
			form.find('.payment-errors').text(response.error.message);
			$('input[type=submit]').attr('disabled',false);
		} else {
			$('#payment_token').val(response.id);
			$('#payment_form')[0].submit();
		}
	}
};


