class RemoveCollectionIdFromProducts < ActiveRecord::Migration[7.2]
  def change
    remove_column :products, :collection_id, :bigint
  end
end
