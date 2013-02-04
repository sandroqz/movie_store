class User < ActiveRecord::Base
  has_many :shopping_carts
  has_secure_password

  def start_shopping
    shopping_carts.create total_value: 0, open_date: Date.today
  end
  def is_owner?(movie)
    !movie.owners.where(id: self.id).empty?
  end
end
