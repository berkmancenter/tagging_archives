class ReportedItem < ActiveRecord::Base
  # attr_accessible :title, :body
  
  belongs_to :user
  belongs_to :tagged_item
  
  self.per_page = 10
end
