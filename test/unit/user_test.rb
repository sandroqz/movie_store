require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @movie1 = Movie.create name: "Movie 1", file_name: "http://localhost/movie1.mov", preview_file_name: "http://localhost/movie1_sample.mov", stream_price: 1.5, download_price: 2.2, description: "Huge text explaining the movie"
    @movie2 = Movie.create name: "Movie 2", file_name: "http://localhost/movie2.mov", preview_file_name: "http://localhost/movie2_sample.mov", stream_price: 1.7, download_price: 2.5, description: "Huge text explaining the movie"
    @movie3 = Movie.create name: "Movie 3", file_name: "http://localhost/movie3.mov", preview_file_name: "http://localhost/movie3_sample.mov", stream_price: 1.9, download_price: 2.8, description: "Huge text explaining the movie"
    @user1 = User.create login: "user1", password: "password1", password_confirmation: "password1", email: "user1@domain.com", name: "User 1"
    @user1.user_movies.create movie: @movie1, active: true, can_download: true
    @user1.user_movies.create movie: @movie2, active: true, can_download: false
    @user1.user_movies.create movie: @movie3, active: true, can_download: false
  end

  test "should list all downloadable movies" do
    downloadable = @user1.movies.downloadable
    assert_includes downloadable, @movie1
    refute_includes downloadable, @movie2
    refute_includes downloadable, @movie3
  end

  test "should list all streamable only movies" do
    streamable = @user1.movies.streamable
    assert_includes streamable, @movie3
    assert_includes streamable, @movie2
    refute_includes streamable, @movie1
  end
end
