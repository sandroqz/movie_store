require File.join(Rails.root, 'lib', 'can_download.rb')

class Movie < ActiveRecord::Base
  has_many :user_movies
  has_many :owners, through: :user_movies, source: :user, extend: CanDownload

  validates :name, :file_name, :preview_file_name, :description, :stream_price, presence: true
  validates :stream_price, :download_price, numericality: {greater_than: 0, allow_nil: true}
  validates :file_name, :preview_file_name, format: {with: /[a-z]{3,4}:\/\/[a-z0-9_\-.]+(\/[a-z0-9\-_]+)+/i}

  def can_be_downloaded_by?(user)
    user_movies.where(user_id: user).first.try(:can_download)
  end
end
