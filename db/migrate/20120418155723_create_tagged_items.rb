class CreateTaggedItems < ActiveRecord::Migration
  def change
    create_table :tagged_items do |t|
      t.string :title
      t.string :urn
      t.string :sequence
      t.timestamps
    end
  end
end
