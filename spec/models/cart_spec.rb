require 'rails_helper'

RSpec.describe Cart, type: :model do
  # create a user
  let(:user) { User.create(email: "adam@exemple.fr", password: "password") }
  # create a cart
  let(:cart) { Cart.create(user: user, status: "pending", total_price: 0) }
  # create 3 products
  before do
    Product.skip_callback(:update, :after, :handle_price_change)
  end
  let(:product1) { Product.create!(name: "T-shirt Blanc à col rond", description: "Un simple T-shirt en coton biologique", price: 19.99) }
  let(:product2) { Product.create!(name: "T-shirt Noir à col rond", description: "Un simple T-shirt en coton biologique", price: 39.99) }
  let(:product3) { Product.create!(name: "T-shirt Bleu à col rond", description: "Un simple T-shirt en coton biologique", price: 29.99) }

  it "has a total price with all cart items" do
    # create 3 cart items
    CartItem.create!(cart: cart, product: product1, price: product1.price)
    CartItem.create!(cart: cart, product: product2, price: product2.price)
    CartItem.create!(cart: cart, product: product3, price: product3.price)
    # expect the total price to be the sum of the 3 products
    expect(cart.total_price).to eq(19.99 + 39.99 + 29.99)
  end

end
