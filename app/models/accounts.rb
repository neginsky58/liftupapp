class Accounts < ActiveRecord::Base
  # attr_accessible :title, :body
  attr_accessible :user_id, :access_token, :stripe_user_id, :refresh_token, :scope, :stripe_publishable_key
  
end
