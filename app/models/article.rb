class Article < ActiveRecord::Base
  self.primary_key= :id
  belongs_to :category

  def self.search(query)
    query.gsub!(/['"%\\]/, '')
    query.strip!
    query = 'zzzzzzzaaazzzzz' if query.blank?
    where("title like '%#{query.mb_chars.downcase}%'")
  end

  def self.check
    puts 'Doing hard work'
    Article.all.each do |art|
      art.low=art.title.mb_chars.downcase
      art.save!
    end
    puts 'End hard work'
  end

end

