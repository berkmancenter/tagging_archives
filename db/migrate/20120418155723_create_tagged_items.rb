class CreateTaggedItems < ActiveRecord::Migration
  def change
    create_table :tagged_items do |t|
      t.string :title
      t.string :urn
      t.string :finding_aid
      t.text :notes
      t.timestamps
    end
    
    add_index :tagged_items, :title
    add_index :tagged_items, :urn
    add_index :tagged_items, :finding_aid
  end
end
