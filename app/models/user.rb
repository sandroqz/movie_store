# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  login           :string(255)
#  password_digest :string(255)
#  name            :string(255)
#  email           :string(255)
#  created_at      :datetime
#  updated_at      :datetime
#

class User < ActiveRecord::Base
  has_many :shopping_carts
  has_many :user_movies
  has_many :movies, through: :user_movies
  scope :streamable, joins(:user_movies).where(user_movies: {can_download: false})
  scope :downloadable, joins(:user_movies).where(user_movies: {can_download: true})

  has_secure_password

  def start_shopping
    shopping_carts.create total_value: 0, open_date: Date.today
  end
  def is_owner?(movie)
    !movie.owners.where(id: self.id).empty?
  end
end
