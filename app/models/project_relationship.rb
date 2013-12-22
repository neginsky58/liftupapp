class ProjectRelationship < ActiveRecord::Base
   attr_accessible :projectuser_id

   belongs_to :user, foreign_key: "follower_id"
   belongs_to :project, foreign_key: "projectuser_id"
end



