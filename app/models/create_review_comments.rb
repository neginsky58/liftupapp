class CreateReviewComments < ActiveRecord::Base
  attr_accessible :content, :project_id, :user_id
end
