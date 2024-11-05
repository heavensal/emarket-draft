class Product < ApplicationRecord
  # id, name, price, category_id, created_at, updated_at

  has_rich_text :description
  has_many_attached :photos
  has_many :collection_assignments, dependent: :destroy
  has_many :collections, through: :collection_assignments
  has_many :cart_items, dependent: :destroy
  has_many :carts, through: :cart_items

  belongs_to :category, optional: true

  validates :name, presence: true, uniqueness: true
  validates :price, presence: true
  validates :price, numericality: { greater_than: 0 }

  after_create :stripe_create
  after_update :stripe_update
  after_update :handle_price_change, if: :saved_change_to_price?

  # créer un produit sur stripe
  def stripe_create
    stripe_product = Stripe::StripeProductService.new(self).create(self)
    self.update(stripe_product_id: stripe_product.id, stripe_price_id: stripe_product.default_price)
  end

  # modifier un produit sur stripe
  def stripe_update
    Stripe::StripeProductService.new(self).update(self)
  end

  # Si le prix de mon produit est modifié, il faut créer un nouveau produit sur stripe et l'assigner à mon produit
  def handle_price_change
    stripe_price = Stripe::StripeProductService.new(self).update_price(self)
    self.update(stripe_price_id: stripe_price.id)
  end
end
