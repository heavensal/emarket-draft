class CartItem < ApplicationRecord
  belongs_to :cart
  belongs_to :product

  validates :price, presence: true
  validates :price, numericality: { greater_or_equal_than: 0 }

  after_create :add_price_to_cart
  after_destroy :remove_price_from_cart

  def add_price_to_cart
    cart.total_price += price
    cart.save!
  end

  def remove_price_from_cart
    cart.total_price -= price
    cart.save!
  end

end
