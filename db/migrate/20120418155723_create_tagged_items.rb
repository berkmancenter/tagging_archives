class CreateTaggedItems < ActiveRecord::Migration
  def change
    create_table :tagged_items do |t|
      t.string :title
      t.string :urn
      t.text :notes
      t.timestamps
    end
    
    add_index :tagged_items, :title
    add_index :tagged_items, :urn
    
    create_table(:tagged_items_users, :id => false) do|t|
      t.references :tagged_item
      t.references :user
    end
    
    add_index :tagged_items_users, :user_id
    add_index :tagged_items_users, :tagged_item_id
  end
end
