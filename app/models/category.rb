class Category < ActiveRecord::Base
	self.primary_key= :id
    has_many :categories, foreign_key: 'parent'
    has_many :articles, foreign_key: 'parent'

    default_scope { order('title') }

    def self.search(query)
      query.gsub!(/['"%\\]/, '')
      query.strip!
      query = 'zzzzzaaazzzzz' if query.blank?
      where("low like '%#{query.mb_chars.downcase}%'")
    end

    def self.check
      puts 'Doing hard work'
      Category.all.each do |art|
        art.low=art.title.mb_chars.downcase
        art.save!
      end
      puts 'End hard work'
    end
end
