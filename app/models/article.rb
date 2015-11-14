class Article < ActiveRecord::Base
	self.primary_key= :id
    belongs_to :category
end
