class Project < ActiveRecord::Base

  attr_accessible :projectshortdesc, :projecttitle, :youtubelink, :image, :category, :category_id, :projectlocation_id,
                  :projectletter, :projectreviewed, :submitreview, :projectimage, :remote_projectimage_url, :permalink,
                  :goal, :funding_period, :pending_started_on

  before_create :make_it_permalink
  
  validates :projectshortdesc, length: { maximum: 150 }
  validates :projecttitle, presence: true, length: { maximum: 50}
  validates :youtubelink, presence: true
  validates :user_id, presence: true
  validates_attachment :image, 
                            content_type: { content_type: ['image/jpeg', 'image/jpg', 'image/png', 'image/gif'] },
                            size: { less_than: 5.megabytes }

  belongs_to :user
  belongs_to :category
  belongs_to :projectlocation

  has_attached_file :image, :styles => { :medium => "320x240>", :regular => "204x150>", :large => "500x500>" }
                    # :url  => "/assets/products/:id/:style/:basename.:extension",
                    # :path => ":rails_root/public/assets/products/:id/:style/:basename.:extension"

  scope :pendingsubmission,  where(:submitreview => false)
  scope :submittedforapproval,  where(:submitreview => true)
  scope :pendingapproval, where(:projectreviewed => false)
  scope :approved,  where(:projectreviewed => true)
  scope :newest, order("created_at desc")
  scope :organizedbyname, order("category")

  # associations for users following projects
  has_many :project_relationships, foreign_key: "projectuser_id"
  has_many :favorited_by, through: :project_relationships, source: :user

  #polymorphic association for comments
  has_many :newcomments, as: :commentable
  has_many :blogupdates, :dependent => :destroy
  has_many :review_comments, :dependent => :destroy
  has_many :team_members, :dependent => :destroy
  has_many :projectcosts, :dependent => :destroy

  mount_uploader :projectimage, ImageUploader

  def make_it_permalink
    loop do
      # this can create permalink with random 8 digit alphanumeric
      self.permalink = SecureRandom.urlsafe_base64(8)
      break self.permalink unless User.where(permalink: self.permalink).exists?
    end
  end

end






  # has_many :reverse_project_relationships, foreign_key: "projectuser_id",
  #                                  class_name:  "ProjectRelationship",
  #                                  dependent:   :destroy
  # has_many :favorited_by, through: :reverse_project_relationships, source: :user


  # has_many :reverse_project_relationships, foreign_key: "followed_id",
  #                                  class_name:  "ProjectRelationship",
  #                                  dependent:   :destroy
  # has_many :followers, through: :reverse_project_relationships, source: :follower