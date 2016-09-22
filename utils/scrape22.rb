require 'open-uri'
require 'nokogiri'
require 'digest/md5'
require 'csv'
require 'unicode_utils'

site = "http://english-lectures.ru/polnyj-spisok-lekcij-i-uprazhnenij-po-anglijskomu-yazyku/"
css = ".post"
cat ="eng"

doc = Nokogiri::HTML(open(site))
links = doc.css(css).css("li")
p links.length

CSV.open("myfile.csv", "w") do |csv|
  CSV.open("myfile2.csv", "w") do |csv2|

    links.each { |link|
        s=link.text.gsub("\n", " ").gsub("\r", "").gsub("\t", "")
        p s
        page = Nokogiri::HTML(open(link.css('a').first["href"]))
        p page.css(css).to_s.length
        next if page.css(css).to_s.length==0
        page.xpath('//@style').remove
        page.xpath('//@face').remove
        page.css("a").remove
        page.css(".postmetadata").remove
        page.css(".widget-content").remove
        page.css(".widget-archive").remove
        page.css(".widget-header").remove
        page.css(".nav").remove
        page.css(".adsbygoogle").remove
        page.css(".alignleft").remove
        page.css(".alignright").remove
        page.css(".menu").remove
        page.css("#menu3").remove
        page.css("script").remove
        page.css("hr").remove
        page.css("br").remove
        page.css("form").remove
        page.css("noindex").remove
        page.css("center").remove
        page.xpath('//comment()').remove
        page.search("img").each do |img|
          img['src']=site +link.css('a').first["href"].partition("/").first + "/"+ img['src']
        end
        
        p page.css(css).to_s.length
        id=Digest::MD5.hexdigest(site+link.css('a').first["href"])

        File.write("material/"+id+".html", page.css(css).to_s)
        csv << [id, cat, s, "2015-12-08", "2015-12-08", UnicodeUtils.downcase(s)]


      
    }
  end
end