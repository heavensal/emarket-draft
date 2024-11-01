class CollectionAssignment < ApplicationRecord
  # id, product_id, collection_id, created_at, updated_at
  belongs_to :product
  belongs_to :collection

  validates :product_id, uniqueness: { scope: :collection_id }
end
