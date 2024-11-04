class DropTablePayMerchants < ActiveRecord::Migration[7.2]
  def change
    execute "TRUNCATE TABLE pay_merchants RESTART IDENTITY CASCADE;"
    drop_table :pay_merchants
  end
end

# class DeleteStupidPayTables < ActiveRecord::Migration[7.2]
#   def change
#     execute "TRUNCATE TABLE pay_charges RESTART IDENTITY CASCADE;"
#     execute "TRUNCATE TABLE pay_subscriptions RESTART IDENTITY CASCADE;"
#     execute "TRUNCATE TABLE pay_customers RESTART IDENTITY CASCADE;"
#     execute "TRUNCATE TABLE pay_merchants RESTART IDENTITY CASCADE;"
#     execute "TRUNCATE TABLE pay_payment_methods RESTART IDENTITY CASCADE;"

#     drop_table :pay_charges
#     drop_table :pay_customers
#     drop_table :pay_merchants
#     drop_table :pay_payment_methods
#     drop_table :pay_subscriptions
#     drop_table :variant_products
#     drop_table :variants
#   end
# end
