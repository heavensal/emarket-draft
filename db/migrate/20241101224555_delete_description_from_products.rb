class DeleteDescriptionFromProducts < ActiveRecord::Migration[7.2]
  def change
    remove_column :products, :description
  end
end
