class CreateUserMovies < ActiveRecord::Migration
  def change
    create_table :user_movies do |t|
      t.belongs_to :user
      t.belongs_to :movie
      t.date :from_date
      t.date :to_date
      t.boolean :active
      t.boolean :can_download

      t.timestamps
    end
    add_index :user_movies, :user_id
    add_index :user_movies, :movie_id
  end
end
