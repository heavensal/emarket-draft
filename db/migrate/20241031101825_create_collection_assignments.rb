class CreateCollectionAssignments < ActiveRecord::Migration[7.2]
  def change
    create_table :collection_assignments do |t|
      t.references :product, null: false, foreign_key: true
      t.references :collection, null: false, foreign_key: true

      t.timestamps
    end

    add_index :collection_assignments, [:product_id, :collection_id], unique: true
  end
end
