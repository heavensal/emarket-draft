class Category < ApplicationRecord
  # id, name, created_at, updated_at
  has_one_attached :photo
  has_many :products
  validates :name, presence: true, uniqueness: true
end
