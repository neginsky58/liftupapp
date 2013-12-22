class DonatePayments < ActiveRecord::Base
  attr_accessible :donator_id, :donate_id, :amount, :transaction_id, :setup, :misc, :donate_affiliate_id, :affiliate_amount, :donator_type 
end
