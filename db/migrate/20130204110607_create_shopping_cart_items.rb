class CreateShoppingCartItems < ActiveRecord::Migration
  def change
    create_table :shopping_cart_items do |t|
      t.belongs_to :shopping_cart
      t.belongs_to :movie
      t.boolean :download
      t.float :price

      t.timestamps
    end
    add_index :shopping_cart_items, :shopping_cart_id
    add_index :shopping_cart_items, :movie_id
  end
end
