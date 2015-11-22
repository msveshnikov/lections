require 'open-uri'
require 'nokogiri'
require 'digest/md5'
require 'csv'
require 'unicode_utils'

site = "http://www.nsu.ru/mmf/tvims/chernova/tv/lec/lec.html"
css = "ul"
cat ="terver"

doc = Nokogiri::HTML(open(site))
doc.css(".contents").remove
links = doc.css(css).css("a")
p links.length

CSV.open("myfile.csv", "w") do |csv|
  CSV.open("myfile2.csv", "w") do |csv2|

    links.each { |link|
      p link.text
      next if link.text==" "
      begin
        page = Nokogiri::HTML(open("http://www.nsu.ru/mmf/tvims/chernova/tv/lec/"+link["href"]))
      rescue
        next
      end
      page.xpath('//@style').remove
      #page.xpath('//@size').remove
      #page.xpath('//@face').remove
      page.css("a").remove
      page.css(".postmetadata").remove
      page.css(".widget-content").remove
      page.css(".widget-archive").remove
      page.css(".widget-header").remove
      page.css(".nav").remove
      page.css(".adsbygoogle").remove
      page.css(".citate").remove
      page.css("script").remove
      page.css("hr").remove
      page.css("br").remove
      page.css("form").remove
      page.css("noindex").remove
      page.css("address").remove
      page.xpath('//comment()').remove
      page.search("img").each do |img|
        img['src']="http://www.nsu.ru/mmf/tvims/chernova/tv/lec/" + img['src']
      end
      c =page.css(css).length
      p page.css("body").to_s.length
      id=Digest::MD5.hexdigest(link["href"])

      if page.css("body").to_s.length<2000
        csv2 << [id, cat, link.text, "20151120", "20151120"]
        cat=id
      else
        #next if link.text[0]!="§"
        File.write("material/"+id+".html","# encoding: koi8-r\n" + page.css("body").to_s)
        csv << [id, cat, link.text, "20151120", "20151120", UnicodeUtils.downcase(link.text)]
      end
    }
  end
end