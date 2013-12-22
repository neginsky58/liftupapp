class Ttwocomment < ActiveRecord::Base
  attr_accessible :content, :newcomment_id, :user_id
  validates :content, presence: true

  belongs_to :newcomment
  belongs_to :user
  belongs_to :project

  scope :newest, order("created_at desc")
end
