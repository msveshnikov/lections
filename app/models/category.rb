class Category < ActiveRecord::Base
	self.primary_key= :id
    has_many :categories, foreign_key: 'parent'
    has_many :articles, foreign_key: 'parent'
end
