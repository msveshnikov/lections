require 'open-uri'
require 'nokogiri'
require 'digest/md5'
require 'csv'
require 'unicode_utils'

site = "http://citforum.ru/database/osbd/contents.shtml"
css = ".document"
cat ="subd"
ol = 0

html = open(site)
doc = Nokogiri::HTML(html.read)
doc.encoding = 'utf-8'
links = doc.css(css).css("a")
p links.length

CSV.open("myfile.csv", "w") do |csv|
  CSV.open("myfile2.csv", "w") do |csv2|

    links.each { |link|
      p link.text
      next if link.text==" "
      begin
        html = open("http://citforum.ru/database/osbd/"+link["href"])
        page = Nokogiri::HTML(html.read)
        page.encoding = 'utf-8'
      rescue
        next
      end
      #next if link["href"].include? "#"
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
      page.css("#menu").remove
      page.css("#menu3").remove
      page.css("script").remove
      page.css("hr").remove
      page.css("br").remove
      page.css("form").remove
      page.css("noindex").remove
      page.css("address").remove
      page.xpath('//comment()').remove
      page.search("img").each do |img|
        img['src']="http://citforum.ru/database/osbd/"+ img['src']
      end

      l=page.css(css).to_s.length
      p l
      id=Digest::MD5.hexdigest(link["href"])

      if page.css(css).to_s.length<3
        csv2 << [id, cat, link.text, "20151120", "20151120"]
        cat=id
      else
        next if l==ol
        File.write("material/"+id+".html", page.css(css).to_s)
        csv << [id, cat, link.text.gsub("\n", ""), "20151120", "20151120", UnicodeUtils.downcase(link.text.gsub("\n", ""))]
        ol=l
      end
    }
  end
end