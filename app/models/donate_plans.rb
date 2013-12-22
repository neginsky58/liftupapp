class DonatePlans < ActiveRecord::Base
  attr_accessible :amount, :user_id, :project_id, :project_title, :setup_amount, :trial_period, :trial_interval, :unit_price, :description, :featured
  
  #belongs_to :creditcards, :class_name => 'Creditcards'
end
