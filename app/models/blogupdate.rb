class Blogupdate < ActiveRecord::Base
  attr_accessible :content, :project_id, :user_id
  validates :content, presence: true

  belongs_to :project
  belongs_to :user

  scope :newest, order("created_at desc")

  # associations for users liking blogupdates
  has_many :bloglikes, foreign_key: "blogupdate_id"
  has_many :liked_by, through: :bloglikes, source: :user
end
