require 'rails_helper'

RSpec.describe Product, type: :model do
  let(:collection) { Collection.create(name: "Naruto") }
  let(:collection_b) { Collection.create(name: "One Piece") }
  let(:category) { Category.create(name: "T-shirt") }
  let(:category_b) { Category.create(name: "Hoodie") }

  describe 'validations' do
    context 'with valid attributes' do
      it 'is valid with a name and a price and no category or collection' do
        product = Product.new(name: "T-shirt Naruto", price: 20.00)
        expect(product).to be_valid
      end

      it 'is valid with a single collection' do
        product = Product.new(name: "T-shirt Naruto", price: 20.00)
        product.collections << collection
        expect(product).to be_valid
      end

      it 'is valid with a category' do
        product = Product.new(name: "T-shirt Naruto", price: 20.00, category: category)
        expect(product).to be_valid
      end

      it 'is valid with 2 collections or more' do
        product = Product.new(name: "T-shirt Naruto", price: 20.00)
        product.collections << collection
        product.collections << collection_b
        expect(product).to be_valid
      end

      it 'is valid with a name, price, description, category and 2 collections' do
        product = Product.new(name: "T-shirt Naruto", price: 20.00, description: "This is a t-shirt", category: category)
        product.collections << collection
        product.collections << collection_b
        expect(product).to be_valid
      end

      it 'is valid without a description' do
        product = Product.new(name: "T-shirt Naruto", price: 20.00, category: category)
        expect(product).to be_valid
      end
    end

    context 'with invalid attributes' do
      it 'is invalid without a name' do
        product = Product.new(name: nil, price: 20.00)
        expect(product).not_to be_valid
      end

      it 'is invalid without a price' do
        product = Product.new(name: "t-shirt naruto", price: nil)
        expect(product).not_to be_valid
      end

      it 'is invalid with a price less than or equal to 0' do
        product = Product.new(name: "t-shirt naruto", price: -1)
        expect(product).not_to be_valid

        product.price = 0
        expect(product).not_to be_valid
      end

      it 'is invalid with a duplicate name' do
        Product.create(name: "t-shirt naruto", price: 20.00)
        product = Product.new(name: "t-shirt naruto", price: 20.00)
        expect(product).not_to be_valid
      end
    end
  end

  describe 'associations' do
    it 'has many collection_assignments' do
      product = Product.create(name: "t-shirt naruto", price: 20.00)
      product.collection_assignments.create(collection: collection)
      product.collection_assignments.create(collection: collection_b)
      expect(product.collection_assignments.count).to eq(2)
    end

    it 'has many collections through collection_assignments' do
      product = Product.create(name: "t-shirt naruto", price: 20.00)
      product.collection_assignments.create(collection: collection)
      product.collection_assignments.create(collection: collection_b)
      expect(product.collections.count).to eq(2)
    end

    it 'belongs to a category' do
      product = Product.create(name: "t-shirt naruto", price: 20.00, category: category)
      expect(product.category).to eq(category)
    end

  end
end
