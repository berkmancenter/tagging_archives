class TaggedItem < ActiveRecord::Base
  acts_as_taggable

  searchable do
    text :title, :more_like_this => true
    text :urn, :more_like_this => true
    text :tag_list, :more_like_this => true

    string :tag_list, :multiple => true

    string :title
    string :urn
  end
end
