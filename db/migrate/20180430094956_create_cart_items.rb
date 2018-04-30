class CreateCartItems < ActiveRecord::Migration
  def change
    create_table :cart_items do |t|
      t.integer :disc_id
      t.integer :cart_id
      t.float :price
      t.integer :amount
      t.timestamps
    end
  end
end
