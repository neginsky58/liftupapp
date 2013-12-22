class PrayerLetter < ActiveRecord::Base
  attr_accessible :description

  validates :description, presence: true

  belongs_to :project
end
