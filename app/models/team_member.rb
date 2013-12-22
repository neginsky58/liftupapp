class TeamMember < ActiveRecord::Base
  attr_accessible :content, :membername, :project_id, :teamuserimage, :remote_teamuserimage_url
  validates :content, presence: true
  validates :membername, presence: true

  belongs_to :project
  mount_uploader :teamuserimage, ImageUploader
end