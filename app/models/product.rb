class Product < ApplicationRecord
  # id, name, price, category_id, created_at, updated_at
  has_many_attached :photos
  has_many :collection_assignments, dependent: :destroy
  has_many :collections, through: :collection_assignments

  belongs_to :category, optional: true

  validates :name, presence: true, uniqueness: true
  validates :price, presence: true
  validates :price, numericality: { greater_than: 0 }
end
