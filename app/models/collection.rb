class Collection < ApplicationRecord
  # id, name, created_at, updated_at
  has_one_attached :photo
  has_many :collection_assignments, dependent: :destroy
  has_many :products, through: :collection_assignments

  validates :name, presence: true, uniqueness: true
end
