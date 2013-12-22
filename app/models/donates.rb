class Donates < ActiveRecord::Base
  attr_accessible :donator_id, :stripe_token, :donate_plan_id, :amount, :state, :donator_type, :donate_affiliate_id, :billing_id, :project_id 
  
  belongs_to :users, :class_name => 'Users', :foreign_key => 'donatoor_id' 
end
