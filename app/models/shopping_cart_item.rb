# == Schema Information
#
# Table name: shopping_cart_items
#
#  id               :integer          not null, primary key
#  shopping_cart_id :integer
#  movie_id         :integer
#  download         :boolean
#  price            :float
#  created_at       :datetime
#  updated_at       :datetime
#

class ShoppingCartItem < ActiveRecord::Base
  belongs_to :shopping_cart
  belongs_to :movie
end
