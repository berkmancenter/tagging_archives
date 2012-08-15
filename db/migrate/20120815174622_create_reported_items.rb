class CreateReportedItems < ActiveRecord::Migration
  def change
    create_table :reported_items do |t|
      t.references :tagged_item
      t.references :user
      t.text :comments
      t.timestamps
    end
    
    add_index :reported_items, :tagged_item_id
    add_index :reported_items, :user_id
  end
end