class ActsAsTaggableOnMigration < ActiveRecord::Migration
  def change
    create_table :tags do |t|
      t.string :name
    end
    
    add_index :tags, :name

    create_table :taggings do |t|
      t.references :tag

      # You should make sure that the column created is
      # long enough to store the required class names.
      t.references :taggable, :polymorphic => true
      t.references :tagger, :polymorphic => true

      # limit is created to prevent mysql error o index lenght for myisam table type.
      # http://bit.ly/vgW2Ql
      t.string :context

      t.datetime :created_at
    end

    add_index :taggings, :tag_id
    add_index :taggings, [:taggable_id, :taggable_type, :context]
  end
end
