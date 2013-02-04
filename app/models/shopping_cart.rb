class ShoppingCart < ActiveRecord::Base
  has_many :shopping_cart_items
  belongs_to :user

  def add_item(movie, want_download)
    item_value = if want_download
      movie.download_price
    else
      movie.stream_price
    end
    self.total_value = self.total_value + item_value
    shopping_cart_items.create(movie: movie, download: want_download, price: item_value)
  end
  def finish
    save!
    shopping_cart_items.each do |sci|
      sci.movie.user_movies.create user: user, from_date: Date.today, active: true, can_download: sci.download
    end
  end
end
