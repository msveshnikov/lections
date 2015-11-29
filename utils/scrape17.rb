require 'open-uri'
require 'nokogiri'
require 'digest/md5'
require 'csv'
require 'unicode_utils'

site = "http://kufas.ru/"
css = ".left"
cat ="java"

doc = Nokogiri::HTML(open(site+"index2.htm"))
#doc.css(".contents").remove
links = doc.css(css).css("a")
p links.length

CSV.open("myfile.csv", "w") do |csv|
  CSV.open("myfile2.csv", "w") do |csv2|

    links.each { |link|
      p link.text
      next if link.text=="(читать далее...)"
      begin
        page = Nokogiri::HTML(open(site+link["href"]))
      rescue
        next
      end
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
        img['src']=site+ img['src']
      end
      #page.css('table').first.remove

      #c =page.css(css).length
      p page.css(css).to_s.length
      id=Digest::MD5.hexdigest(site+link["href"])

      if link.text.length >5
        s=link.text.gsub("\n", " ").gsub("\r", "")
        csv << [id, "java", s, "20151120", "20151120", UnicodeUtils.downcase(s)]
        cat=id
      else
        File.open("material/"+cat+".html", 'a') { |f| f.write(page.css(css).to_s) }
      end
    }
  end
end