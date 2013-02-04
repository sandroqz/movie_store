require 'test_helper'

class ShoppingCartTest < ActiveSupport::TestCase
  def setup
    @movie1 = Movie.create name: "Movie 1", file_name: "http://localhost/movie1.mov", preview_file_name: "http://localhost/movie1_sample.mov", stream_price: 1.5, download_price: 2.2, description: "Huge text explaining the movie"
    @movie2 = Movie.create name: "Movie 2", file_name: "http://localhost/movie2.mov", preview_file_name: "http://localhost/movie2_sample.mov", stream_price: 1.7, download_price: 2.5, description: "Huge text explaining the movie"
    @user1 = User.create login: "user1", password: "password1", password_confirmation: "password1", email: "user1@domain.com", name: "User 1"
    @user2 = User.create login: "user2", password: "password2", password_confirmation: "password2", email: "user2@domain.com", name: "User 2"
  end
  test "user should start shopping with a new shopping cart" do
    cart = @user1.start_shopping
    refute_nil cart
    assert_instance_of ShoppingCart, cart
    refute_predicate cart, :new_record?
  end
  test "adding items to the shopping cart should update the total value" do
    cart = @user1.start_shopping
    total = cart.total_value || 0
    cart.add_item @movie1, true
    assert_equal total + @movie1.download_price, cart.total_value
    total = cart.total_value || 0
    cart.add_item @movie2, false
    assert_equal total + @movie2.stream_price, cart.total_value
  end
  test "after buying a movie, a user should be owner of the movie" do
    cart = @user1.start_shopping
    cart.add_item @movie1, true
    refute @user1.is_owner?(@movie1)
    cart.finish
    assert @user1.is_owner?(@movie1)
  end
  test "after buying a movie for download, a user should be able to download" do
    cart = @user1.start_shopping
    cart.add_item @movie1, true
    cart.add_item @movie2, false
    refute @movie1.can_be_downloaded_by?(@user1)
    refute @movie1.can_be_downloaded_by?(@user2)
    cart.finish
    assert @movie1.can_be_downloaded_by?(@user1)
    refute @movie1.can_be_downloaded_by?(@user2)
  end
end
