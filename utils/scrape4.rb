require 'open-uri'
require 'nokogiri'
require 'digest/md5'
require 'csv'
require 'unicode_utils'

site = "http://www.rae.ru/monographs/51/"
css = ".text"
cat ="draw"

doc = Nokogiri::HTML(open(site))
links = doc.css(css).css("a")
p links.length

CSV.open("myfile.csv", "w") do |csv|
  CSV.open("myfile2.csv", "w") do |csv2|

    links.each { |link|
      p link.text
      begin
        page = Nokogiri::HTML(open("http://www.rae.ru/"+link["href"]))
      rescue
        next
      end
      page.xpath('//@style').remove
      page.css("a").remove
      page.css(".postmetadata").remove
      page.css(".nav").remove
      page.css(".adsbygoogle").remove
      page.css("script").remove
      page.xpath('//comment()').remove
      page.search("img").each do |img|
        #img['src']=site + img['src']
      end
      c =page.css(css).length
      p page.css(css).to_s.length
      id=Digest::MD5.hexdigest(link["href"])

      if page.css(css).to_s.length<350
        csv2 << [id, cat, link.text, "20151120", "20151120"]
        cat=id
      else
        File.write("material/"+id+".html", "# encoding: windows-1251\n" +page.css(css).to_s)
        csv << [id, cat, link.text, "20151120", "20151120", UnicodeUtils.downcase(link.text)]
      end
    }
  end
end