class AddColumnsStripeToProducts < ActiveRecord::Migration[7.2]
  def change
    add_column :products, :stripe_product_id, :string
    add_column :products, :stripe_price_id, :string
  end
end
