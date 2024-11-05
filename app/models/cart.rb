class Cart < ApplicationRecord
  belongs_to :user

  has_many :cart_items, dependent: :destroy
  has_many :products, through: :cart_items

  validates :total_price, presence: true

  validates :total_price, numericality: { greater_or_equal_than: 0 }
  # status: pending, awaiting_payment, paid, shipped, abandoned
  validates :status, presence: true
  validates :status, inclusion: { in: %w(pending awaiting_payment paid shipped abandoned) }
end
