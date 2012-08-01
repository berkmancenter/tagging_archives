class TaggedItem < ActiveRecord::Base
  acts_as_taggable
  
  has_and_belongs_to_many :users
  validates_presence_of :title, :urn, :tag_list
  validates_uniqueness_of :urn
  
  self.per_page = 10

  searchable :auto_index => true, :auto_remove => true do
    text :notes, :more_like_this => true
    text :tag_list, :more_like_this => true

    string :tag_list, :multiple => true

  end
end
