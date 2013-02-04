class User < ActiveRecord::Base
  has_many :shopping_carts
  has_many :user_movies
  has_many :movies, through: :user_movies do
    def streamable
      where("user_movies.can_download=?", false)
    end
    def downloadable
      where("user_movies.can_download=?", true)
    end
  end

  has_secure_password

  def start_shopping
    shopping_carts.create total_value: 0, open_date: Date.today
  end
  def is_owner?(movie)
    !movie.owners.where(id: self.id).empty?
  end
end
