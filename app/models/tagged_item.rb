class TaggedItem < ActiveRecord::Base
  acts_as_taggable
  
  validates_presence_of :title, :urn
  validates_uniqueness_of :urn

  searchable :auto_index => true, :auto_remove => true do
    #text :title, :more_like_this => true
    #text :urn, :more_like_this => true
    text :tag_list, :more_like_this => true

    string :tag_list, :multiple => true

    string :title
    string :urn
  end
end
