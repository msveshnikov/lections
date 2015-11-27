require 'open-uri'
require 'nokogiri'
require 'digest/md5'
require 'csv'
require 'unicode_utils'

site = "http://www.rimoyt.com/materialovedenie/materialovedenie.php/"
css = ".text_area"
cat ="metall"

doc = Nokogiri::HTML(open(site))
#doc.css(".contents").remove
links = doc.css(css).css("a")
p links.length

CSV.open("myfile.csv", "w") do |csv|
  CSV.open("myfile2.csv", "w") do |csv2|

    links.each { |link|
      p link.text
      next if link.text==" "
      begin
        page = Nokogiri::HTML(open("http://www.rimoyt.com/materialovedenie/"+link["href"]))
      rescue
        next
      end
      next if link["href"].include? "#"
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
        img['src']=site+ img['src']
      end
      #c =page.css(css).length
      p page.css(css).to_s.length
      id=Digest::MD5.hexdigest(link["href"])

      if page.css(css).to_s.length<100
        csv2 << [id, cat, link.text, "20151120", "20151120"]
        cat=id
      else
        #next if link.text[0]!="§"
        File.write("material/"+id+".html", "# encoding: windows-1251\n" + page.css(css).to_s)
        csv << [id, cat, link.text.gsub("\n",""), "20151120", "20151120", UnicodeUtils.downcase(link.text.gsub("\n",""))]
      end
    }
  end
end