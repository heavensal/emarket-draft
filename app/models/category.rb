class Category < ApplicationRecord
  # id, name, created_at, updated_at
  has_one_attached :photo
  has_many :products
  validates :name, presence: true, uniqueness: true

  # ransack search
  def self.ransackable_attributes(_auth_object = nil)
    %w[name id created_at updated_at]
  end

  def self.ransackable_associations(_auth_object = nil)
    %w[products]
  end
end
