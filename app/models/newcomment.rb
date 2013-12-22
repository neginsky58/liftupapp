class Newcomment < ActiveRecord::Base
  attr_accessible :content, :user_id
  belongs_to :commentable, polymorphic: true
  has_many :ttwocomments, :dependent => :destroy

  belongs_to :user

  scope :newest, order("created_at desc")

  validates :content, presence: true
end