class Bloglike < ActiveRecord::Base
  attr_accessible :blogupdate_id

  belongs_to :user, foreign_key: "user_id"
  belongs_to :blogupdate, foreign_key: "blogupdate_id"
end