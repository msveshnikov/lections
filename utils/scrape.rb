require 'open-uri'
require 'nokogiri'
require 'digest/md5'
require 'csv'
require 'unicode_utils'

doc = Nokogiri::HTML(open("http://physics-lectures.ru/"))
links = doc.css(".post").css("a")
p links.length

CSV.open("myfile.csv", "w") do |csv|
  CSV.open("myfile2.csv", "w") do |csv2|
    cat="data2"

    links.each { |link|
      p link.text
      page = Nokogiri::HTML(open(link["href"]))
      page.xpath('//@style').remove
      page.css("a").remove
      page.css(".postmetadata").remove
      page.css(".navigation").remove
      page.css(".adsbygoogle").remove
      page.css("script").remove
      page.xpath('//comment()').remove
      c=page.css(".post").length
      id=Digest::MD5.hexdigest(link["href"])

      if c==0
        csv2 << [id, cat, link.text, "20151119", "20151119"]
        cat=id
      else
        File.write("material/"+id+".html", page.css(".post"))
        csv << [id, cat, link.text, "20151119", "20151119", UnicodeUtils.downcase(link.text)]
      end
    }
  end
end