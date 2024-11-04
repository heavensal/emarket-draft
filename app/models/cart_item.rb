class CartItem < ApplicationRecord
  belongs_to :cart
  belongs_to :product

  validates :price, presence: true
  validates :price, numericality: { greater_or_equal_than: 0 }

end
