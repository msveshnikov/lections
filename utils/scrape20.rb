require 'open-uri'
require 'nokogiri'
require 'digest/md5'
require 'csv'
require 'unicode_utils'

site = "http://www.e-reading.club/book.php?book=103856"
css = "#zmist"
cat ="bank"

doc = Nokogiri::HTML(open(site))
links = doc.css(css).css("li")
p links.length

CSV.open("myfile.csv", "w") do |csv|
  CSV.open("myfile2.csv", "w") do |csv2|

    links.each { |link|
      p link.text
      if !link.css('a').first
        id=Digest::MD5.hexdigest(site+link.text)
        csv2 << [id, "bank", link.text, "20151120", "20151120"]
        #cat=id
      else
        page = Nokogiri::HTML(open(link.css('a').first["href"]))
        page.xpath('//@style').remove
        page.css("a").remove
        page.css(".postmetadata").remove
        page.css(".widget-content").remove
        page.css(".widget-archive").remove
        page.css(".widget-header").remove
        page.css(".nav").remove
        page.css(".adsbygoogle").remove
        page.css(".menu").remove
        page.css("#menu3").remove
        page.css("script").remove
        page.css("hr").remove
        page.css("br").remove
        page.css("form").remove
        page.css("noindex").remove
        page.css("address").remove
        page.xpath('//comment()').remove
        page.search("img").each do |img|
          img['src']=site + img['src']
        end

        p page.css(".section").to_s.length
        id=Digest::MD5.hexdigest(site+link.css('a').first["href"])

        File.write("material/"+id+".html", "# encoding: windows-1251\n" +page.css(".section").to_s)
        csv << [id, cat, link.text, "20151120", "20151120", UnicodeUtils.downcase(link.text)]


      end
    }
  end
end