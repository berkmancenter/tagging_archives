class AddLocationToTaggedItems < ActiveRecord::Migration
  def change
    add_column :tagged_items, :box, :string
    add_column :tagged_items, :folder, :string
  end
end
