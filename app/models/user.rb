class User < ApplicationRecord
  acts_as_token_authenticatable

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def admin?
    is_admin
  end

  has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100#" }, :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/

  has_many :videos
  has_many :video_comments
  has_many :comments_for_videos, through: :video_comments, source: :video

  has_many :battle_comments
  has_many :comments_for_battles, through: :battle_comments, source: :battle

  has_many :favor_left_video_relationships
  has_many :favor_left_videos, through: :favor_left_video_relationships, source: :battle

  has_many :favor_right_video_relationships
  has_many :favor_right_videos, through: :favor_right_video_relationships, source: :battle

  def has_follow_left?(battle)
    favor_left_videos.include?(battle)
  end

  def follow_left!(battle)
    favor_left_videos << battle
  end

  def unfollow_left!(battle)
    favor_left_videos.delete(battle)
  end

  def has_follow_right?(battle)
    favor_right_videos.include?(battle)
  end

  def follow_right!(battle)
    favor_right_videos << battle
  end

  def unfollow_right!(battle)
    favor_right_videos.delete(battle)
  end

  def display_name
    self.email.split("@").first
  end
  
  
   def reset_authentication_token!
     self.authentication_token = generate_authentication_token("")
     self.save
   end
 
  private
  def generate_authentication_token(token_generator)
    loop do
      token = Devise.friendly_token
      break token unless User.where(authentication_token: token).first
    end
  end
end
