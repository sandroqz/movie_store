class Movie < ActiveRecord::Base
  has_many :user_movies
  has_many :owners, through: :user_movies, source: :user
  scope :streamable, joins(:user_movies).where(user_movies: {can_download: false})
  scope :downloadable, joins(:user_movies).where(user_movies: {can_download: true})

  validates :name, :file_name, :preview_file_name, :description, :stream_price, presence: true
  validates :stream_price, :download_price, numericality: {greater_than: 0, allow_nil: true}
  validates :file_name, :preview_file_name, format: {with: /[a-z]{3,4}:\/\/[a-z0-9_\-.]+(\/[a-z0-9\-_]+)+/i}

  def can_be_downloaded_by?(user)
    user_movies.where(user_id: user).first.try(:can_download)
  end

  def self.list_by_criteria(text, want_download, minimum_price, maximum_price)
    result = scoped
    result = result.where("name like :text or description like :text", text: "%#{text}%") if text
    result = result.where("download_price is not null") if want_download
    result = result.where("stream_price > :min or download_price > :min", min: minimum_price) if minimum_price
    result = result.where("stream_price < :max or download_price < :max", max: maximum_price) if maximum_price
    result
  end
end
