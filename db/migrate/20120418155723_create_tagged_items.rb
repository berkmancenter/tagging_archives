class CreateTaggedItems < ActiveRecord::Migration
  def change
    create_table :tagged_items do |t|
      t.string :title
      t.string :urn
      t.string :sequence
      t.timestamps
    end
    
    add_index :tagged_items, :title
    add_index :tagged_items, :urn
    add_index :tagged_items, :sequence
  end
end
