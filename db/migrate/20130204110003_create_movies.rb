class CreateMovies < ActiveRecord::Migration
  def change
    create_table :movies do |t|
      t.string :name
      t.string :file_name
      t.text :description
      t.string :preview_file_name
      t.float :stream_price
      t.float :download_price

      t.timestamps
    end
  end
end
