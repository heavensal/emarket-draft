require 'rails_helper'

RSpec.describe Collection, type: :model do
  let(:collection_a) { Collection.create(name: "Naruto") }
  let(:product_a) { Product.create(name: "T-shirt Naruto", price: 20.00) }
  let(:product_b) { Product.create(name: "T-shirt One Piece", price: 20.00) }

  context "validations" do
    it "is valid with a name" do
      collection = Collection.create(name: "Naruto")
      expect(collection).to be_valid
    end

  end

  context "with invalid attributes" do
    it "is invalid without a name" do
      collection = Collection.create(name: nil)
      expect(collection).not_to be_valid
    end

    it "no valid if 2 collections with same name" do
      Collection.create(name: "Naruto")
      collection = Collection.create(name: "Naruto")
      expect(collection).not_to be_valid
    end
  end

  context "associations" do
    describe "collection_assignments" do

      context "with valid attributes" do

        it "has many collection_assignments" do
          collection_a.collection_assignments.create(product: product_a)
          collection_a.collection_assignments.create(product: product_b)
          expect(collection_a.collection_assignments.count).to eq(2)
        end

        it "has many products through collection_assignments" do
          collection_a.collection_assignments.create(product: product_a)
          collection_a.collection_assignments.create(product: product_b)
          expect(collection_a.products.count).to eq(2)
        end

      end

      context "with invalid attributes" do

        it 'is invalid with 2 identical products' do
          collection_a.products << product_a
          collection_a.products << product_a
          expect(collection_a).not_to be_valid
        end

      end

    end
  end
end
