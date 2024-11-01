require "rails_helper"

RSpec.describe Category, type: :model do
  it "is valid with a name" do
    category = Category.create(name: "Naruto")
    expect(category).to be_valid
  end

  it "is invalid without a name" do
    category = Category.create(name: nil)
    expect(category).not_to be_valid
  end

  it "no valid if 2 categories with same name" do
    Category.create(name: "Naruto")
    category = Category.create(name: "Naruto")
    expect(category).not_to be_valid
  end

  it "is valid with many products" do
    category = Category.create(name: "Naruto")
    collection = Collection.create(name: "T-shirt")
    product_a = Product.create(name: "T-shirt Naruto", price: 20.00, collection: collection, category: category)
    product_b = Product.create(name: "T-shirt Sasuke", price: 20.00, collection: collection, category: category)
    expect(category.products).to include(product_a, product_b)
  end
end
