class Article < ActiveRecord::Base
  self.primary_key= :id
  belongs_to :category

  def self.search(query)
    query.gsub!(/['"%\\]/, '')
    query.strip!
    query = 'zzzzzzzaaazzzzz' if query.blank?
    query[0] = query[0].mb_chars.upcase

    where("title like '%#{query.mb_chars.downcase}%'")
  end

end
