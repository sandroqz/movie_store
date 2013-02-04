class CreateMovieDownloads < ActiveRecord::Migration
  def change
    create_table :movie_downloads do |t|
      t.belongs_to :user_movie
      t.date :download_date

      t.timestamps
    end
    add_index :movie_downloads, :user_movie_id
  end
end
