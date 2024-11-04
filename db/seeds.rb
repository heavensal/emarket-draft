# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# test to create a product on stripe via the api
require "stripe"

# stripe_product = Stripe::Product.create(
#   {
#     name: 'T-shirt Blanc à col rond',
#     description: 'Un simple T-shirt en coton biologique',
#     default_price_data: {
#       currency: 'eur',
#       unit_amount: 1999
#     },
#     images: [ "https://www.1083.fr/media/catalog/product/cache/2a03f66ee6f95adf7f510217df4a06fa/3/0/304-x00-00co1xxxxxx_blanc___01.jpg" ],
#     shippable: true
#   }
# )

# p stripe_product

stripe_product = Stripe::Product.retrieve('prod_R9TmFxvr5LPyDO')

p stripe_product
