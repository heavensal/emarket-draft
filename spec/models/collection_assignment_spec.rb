require 'rails_helper'

RSpec.describe CollectionAssignment, type: :model do
  let(:collection) { Collection.create(name: "Naruto") }
  let(:collection_b) { Collection.create(name: "One Piece") }
  let(:product) { Product.create(name: "T-shirt Naruto", price: 20.00) }
  let(:product_b) { Product.create(name: "T-shirt One Piece", price: 20.00) }

  describe 'validations' do
    context 'with valid attributes' do
      it 'is valid with a product and a collection' do
        collection_assignment = CollectionAssignment.new(product: product, collection: collection)
        expect(collection_assignment).to be_valid
      end

      it 'is valid with a product and 2 collections' do
        collection_assignment = CollectionAssignment.new(product: product, collection: collection)
        collection_assignment_b = CollectionAssignment.new(product: product, collection: collection_b)
        expect(collection_assignment_b).to be_valid
      end

      it 'is valid with 2 products and a collection' do
        collection_assignment = CollectionAssignment.new(product: product, collection: collection)
        collection_assignment_b = CollectionAssignment.new(product: product_b, collection: collection)
        expect(collection_assignment_b).to be_valid
      end

      it 'is valid with 2 products and 2 collections' do
        collection_assignment = CollectionAssignment.new(product: product, collection: collection)
        collection_assignment_b = CollectionAssignment.new(product: product, collection: collection_b)
        expect(collection_assignment_b).to be_valid
      end
    end

    context 'with invalid attributes' do
      it 'is invalid without a product' do
        collection_assignment = CollectionAssignment.new(product: nil, collection: collection)
        expect(collection_assignment).not_to be_valid
      end

      it 'is invalid without a collection' do
        collection_assignment = CollectionAssignment.new(product: product, collection: nil)
        expect(collection_assignment).not_to be_valid
      end

      it 'is invalid with a duplicate product and collection' do
        CollectionAssignment.create(product: product, collection: collection)
        collection_assignment = CollectionAssignment.new(product: product, collection: collection)
        expect(collection_assignment).not_to be_valid
      end

      it 'is invalid with a duplicate product and collection' do
        CollectionAssignment.create(product: product, collection: collection)
        collection_assignment = CollectionAssignment.new(product: product, collection: collection)
        expect(collection_assignment).not_to be_valid
      end
    end
  end
end
