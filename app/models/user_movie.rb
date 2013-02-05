# == Schema Information
#
# Table name: user_movies
#
#  id           :integer          not null, primary key
#  user_id      :integer
#  movie_id     :integer
#  from_date    :date
#  to_date      :date
#  active       :boolean
#  can_download :boolean
#  created_at   :datetime
#  updated_at   :datetime
#

class UserMovie < ActiveRecord::Base
  belongs_to :user
  belongs_to :movie
end
