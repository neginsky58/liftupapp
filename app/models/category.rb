class Category < ActiveRecord::Base
  attr_accessible :name

  has_many :projects

  scope :newest, order("created_at desc")
  scope :organized, order("name")
  scope :pendingsubmission,  where(:submitreview => false)
  scope :submittedforapproval,  where(:submitreview => true)
  scope :pendingapproval, where(:projectreviewed => false)
  scope :approved,  where(:projectreviewed => true)

end
