class DropStupidTables < ActiveRecord::Migration[7.2]
  def up
    drop_table :variant_products
    drop_table :variants
  end
end
