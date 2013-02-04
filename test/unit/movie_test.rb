require 'test_helper'

class MovieTest < ActiveSupport::TestCase
  def setup
    @movie1 = Movie.create name: "Movie 1", file_name: "http://localhost/movie1.mov", preview_file_name: "http://localhost/movie1_sample.mov", stream_price: 1.5, download_price: 2.2, description: "Huge text explaining the movie"
    @movie2 = Movie.create name: "Movie 2", file_name: "http://localhost/movie2.mov", preview_file_name: "http://localhost/movie2_sample.mov", stream_price: 1.7, download_price: 2.5, description: "Huge text explaining the movie"
    @user1 = User.create login: "user1", password: "password1", password_confirmation: "password1", email: "user1@domain.com", name: "User 1"
    @user2 = User.create login: "user2", password: "password2", password_confirmation: "password2", email: "user2@domain.com", name: "User 2"
    @movie1.user_movies.create user: @user1, active: true, can_download: true
    @movie1.user_movies.create user: @user2, active: true, can_download: false
  end
  test "should have know who already own the movie" do
    assert_equal 2, @movie1.owners.size, "should have 2 owners"
  end
  test "should list the users that cannot download this movie" do
    streamable = @movie1.owners.streamable
    assert_includes streamable, @user2
    refute_includes streamable, @user1
  end
  test "should list the users who already own the movie" do
    streamable = @movie1.owners.streamable
    assert_includes streamable, @user2
    refute_includes streamable, @user1
  end
  test "should list the users that can download this movie" do
    downloadable = @movie1.owners.downloadable
    assert_includes downloadable, @user1
    refute_includes downloadable, @user2
  end
  test "should have know if one user can download the movie" do
    assert @movie1.can_be_downloaded_by?(@user1), "can be downloaded by user 1"
    assert !@movie1.can_be_downloaded_by?(@user2), "cannot be downloaded by user 2"
    assert !@movie2.can_be_downloaded_by?(@user1), "cannot be downloaded by user 1"
    assert !@movie2.can_be_downloaded_by?(@user2), "cannot be downloaded by user 2"
  end
  test "should require :name, :file_name, :preview_file_name, :description and :stream_price" do
    @movie = Movie.create
    assert @movie.errors[:name].any?
    assert @movie.errors[:file_name].any?
    assert @movie.errors[:preview_file_name].any?
    assert @movie.errors[:description].any?
    assert @movie.errors[:stream_price].any?
  end
  test "prices should be a number" do
    @movie = Movie.create name: "Movie 1", file_name: "http://localhost/movie1.mov", preview_file_name: "http://localhost/movie1_sample.mov", stream_price: "a", download_price: "b", description: "Huge text explaining the movie"
    assert @movie.erros[:stream_price].any?
    assert @movie.erros[:download_price].any?
    @movie.download_price = 1.5
    @movie.stream_price = 2
    @movie.save
    assert @movie.erros[:stream_price].empty?
    assert @movie.erros[:download_price].empty?
  end
  test "file names should be an URL" do
    @movie = Movie.create name: "Movie 1", file_name: "a", preview_file_name: "a", stream_price: "a", download_price: "b", description: "Huge text explaining the movie"
    assert @movie.erros[:file_name].any?, "File name is not an URL"
    assert @movie.erros[:preview_file_name].any?, "Preview file name is not an URL"
    @movie.file_name = "http://localhost/teste"
    @movie.preview_file_name = "http://localhost/file.mov"
    @movie.save
    assert @movie.erros[:file_name].empty?, "File name is a URL"
    assert @movie.erros[:preview_file_name].empty?, "preview file name is a URL"
  end
end
