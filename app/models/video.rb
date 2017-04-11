class Video < ApplicationRecord
  mount_uploader :image, ImageUploader
  mount_uploader :video, VideoUploader
  validates :title, presence: true

  belongs_to :user
  has_many :video_comments
  has_many :comments_from_user, through: :video_comments, source: :user

  has_many :favor_videos_relationships
  has_many :followers, through: :favor_videos_relationships, source: :user
end
