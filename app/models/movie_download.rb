# == Schema Information
#
# Table name: movie_downloads
#
#  id            :integer          not null, primary key
#  user_movie_id :integer
#  download_date :date
#  created_at    :datetime
#  updated_at    :datetime
#

class MovieDownload < ActiveRecord::Base
  belongs_to :user_movie
end
