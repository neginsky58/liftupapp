class ReviewComment < ActiveRecord::Base
  attr_accessible :content, :project_id, :user_id
  validates :content, presence: true

  belongs_to :project
  belongs_to :user

  scope :newest, order("created_at desc")
end
