class Creditcards < ActiveRecord::Base
  attr_accessible :user_id, :first_name, :last_name, :name, :stripe_token, :stripe_customer_id, :exp_year, :exp_month, :cvv
  
  
  belongs_to :user
  
  
  def name
    [self.first_name, self.last_name].join(' ').strip()
  end

  def name=(name)
    tokens = name.strip.split(/\s+/)
    self.first_name = self.last_name = nil

    self.first_name = tokens[0].titleize if tokens[0] and tokens[0]   =~ /[A-Za-z]+/
    self.last_name = tokens[1].titleize if tokens[1] and tokens[1] =~ /[A-Za-z]+/
  end
  
end
