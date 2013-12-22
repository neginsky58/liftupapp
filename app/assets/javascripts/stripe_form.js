Stripe.setPublishableKey('pk_test_YCvaOizJJldujICMihQUuuBT');
 
var stripeResponseHandler = function(status, response) {
	var $form = $('#new_creditcards');
	 
	if (response.error) {
		// Show the errors on the form
		$form.find('.validate-errors').text(response.error.message);
		$form.find('.validate-errors').show();
		$form.find('button').prop('disabled', false);
	} else {
		// token contains id, last4, and card type
		var token = response.id;
		// Insert the token into the form so it gets submitted to the server
		$form.append($('<input type="hidden" name="creditcards[stripe_token]" />').val(token));
		// and re-submit
		
		$form.get(0).submit();
	}
};
 
jQuery(function($) {
	$('#new_creditcards').submit(function(e) {
		var $form = $(this);		
		// Disable the submit button to prevent repeated clicks
		$form.find('button').prop('disabled', true);
		 
		Stripe.createToken($form, stripeResponseHandler);
		 
		// Prevent the form from submitting with the default action
		return false;
	});
});