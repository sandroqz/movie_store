class CreateShoppingCarts < ActiveRecord::Migration
  def change
    create_table :shopping_carts do |t|
      t.belongs_to :user
      t.date :open_date
      t.date :close_date
      t.float :total_value

      t.timestamps
    end
    add_index :shopping_carts, :user_id
  end
end
