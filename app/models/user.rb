class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, #:recoverable, 
  :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :name, 
                  :aboutuser, :image, :remote_image_url, :permalink
  # attr_accessible :title, :body
  before_save :create_remember_token
  before_create :make_it_permalink

  mount_uploader :image, ImageUploader

  validates :name, presence: true
  validates :password_confirmation, presence: true

  
  has_many :accounts, :class_name => 'Accounts'
  has_many :creditcards, :class_name =>'Creditcards'

  has_many :projects
  has_many :newcomments, :dependent => :destroy
  has_many :blogupdates
  has_many :review_comments, :dependent => :destroy
  has_many :ttwocomments

  has_many :relationships, foreign_key: "follower_id", dependent: :destroy
  has_many :followed_users, through: :relationships, source: :followed
  has_many :reverse_relationships, foreign_key: "followed_id",
                                   class_name:  "Relationship",
                                   dependent:   :destroy
  has_many :followers, through: :reverse_relationships, source: :follower

  
  
  scope :pendingsubmission,  where(:submitreview => false)
  scope :submittedforapproval,  where(:submitreview => true)
  scope :pendingapproval, where(:projectreviewed => false)
  scope :approved,  where(:projectreviewed => true)
  scope :newest, order("created_at desc")

  # associations for following projects
  has_many :project_relationships, foreign_key: "follower_id"
  has_many :followed_projects, through: :project_relationships, source: :project

  # has_many :project_relationships, foreign_key: "follower_id", dependent: :destroy
  # has_many :followed_projects, through: :project_relationships, source: :followed


  #has_many :creditcards, :class_name => "Creditcards"   
  has_many :donate_plans, :class_name => "DonatePlans"  
  has_many :donates, :class_name => "Donates"
  
  # associations for liking blogupdates
  has_many :bloglikes, foreign_key: "user_id"
  has_many :liked_blogupdates, through: :bloglikes, source: :blogupdate


  def feed
  end

  def following?(other_user)
    relationships.find_by_followed_id(other_user.id)
  end

  def follow!(other_user)
    relationships.create!(followed_id: other_user.id)
  end

  def unfollow!(other_user)
    relationships.find_by_followed_id(other_user.id).destroy
  end

  def following_project?(project)
    project_relationships.find_by_projectuser_id(project.id)
  end

  def follow_project!(project)
    project_relationships.create!(projectuser_id: project.id)
  end

  def project_unfollow!(project)
    project_relationships.find_by_projectuser_id(project.id).destroy
  end

  def liking_blogupdate?(blogupdate)
    bloglikes.find_by_blogupdate_id(blogupdate.id)
  end

  def like_blogupdate!(blogupdate)
    bloglikes.create!(blogupdate_id: blogupdate.id)
  end

  def blogupdate_unlike!(blogupdate)
    bloglikes.find_by_blogupdate_id(blogupdate.id).destroy
  end

  def make_it_permalink
    loop do
      # this can create permalink with random 8 digit alphanumeric
      self.permalink = SecureRandom.urlsafe_base64(8)
      break self.permalink unless User.where(permalink: self.permalink).exists?
    end
  end

  private

    def create_remember_token
      self.remember_token = SecureRandom.urlsafe_base64
    end


end