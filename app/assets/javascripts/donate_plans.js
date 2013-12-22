
jQuery(function($) {
	
	// amount is decimal value .99 
	function getFee(amount){
		fee = ((amount + 0.30)/0.971) - amount;
		fee = parseFloat(fee.toFixed(2));
				
		return fee;
	}
	
	$('#donate_plans_amount').keyup(function(){
		
		amount = parseFloat($(this).val());
		amount = parseFloat(amount.toFixed(2))
		
		setup_amount = amount * 0.971 - 0.30		
		setup_amount = parseFloat(setup_amount.toFixed(2));
		
		fee = getFee(setup_amount);
		
		setup_amount = amount - fee;
		fee = getFee(setup_amount);
		//total_fee = getFee(setup_amount);
				
		fee = fee.toFixed(2);				
		$('.fee-value').html('$' + fee);
		$('#donate_plans_setup_amount').val(setup_amount);
	});
	$('#donate_plans_setup_amount').keyup(function(){
		
		setup_amount = parseFloat($(this).val());
		setup_amount = parseFloat(setup_amount.toFixed(2));
				
		fee = getFee(setup_amount);		
		amount = setup_amount + fee;
						
		fee = fee.toFixed(2);
		$('.fee-value').html('$'+fee);
		$('#donate_plans_amount').val(amount);		
	});
})