class Projectcost < ActiveRecord::Base
  attr_accessible :costactual, :costestimate, :project_id, :category
  validates :category, presence: true

  belongs_to :project
  scope :organizedbyname, order("category")
  scope :organizedbycostestimate, order("costestimate")
end