class ShoppingCart < ActiveRecord::Base
  has_many :shopping_cart_items, before_add: Proc.new {|sc, item|
    item_value = if item.download
      item.movie.download_price
    else
      item.movie.stream_price
    end
    item.price = item_value
    sc.total_value = sc.total_value + item_value
  }, before_remove: :subtract_price
  belongs_to :user

  def add_item(movie, want_download)
    shopping_cart_items.create(movie: movie, download: want_download)
  end

  def finish
    save!
    shopping_cart_items.each do |sci|
      sci.movie.user_movies.create user: user, from_date: Date.today, active: true, can_download: sci.download
    end
  end

  def subtract_price(item)
    self.total_value = self.total_value - item.price
  end
end
