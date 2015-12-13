require 'open-uri'
require 'nokogiri'
require 'digest/md5'
require 'csv'
require 'unicode_utils'

site = "http://bobych.ru/lection/matemat/"
css = ".column-2"
cat ="alg"

doc = Nokogiri::HTML(open(site))
links = doc.css(css).css("li")
p links.length

CSV.open("myfile.csv", "w") do |csv|
  CSV.open("myfile2.csv", "w") do |csv2|

    links.each { |link|
      s=link.text.gsub("\n", " ").gsub("\r", "").gsub("\t", "")
      p s
      if link.css("h3").first
        id=Digest::MD5.hexdigest(site+s)
        csv2 << [id, "alg", link.css('h3,h2').text, "2015-12-08", "2015-12-08", UnicodeUtils.downcase(link.css('h3,h2').text)]
        cat=id
      else
        page = Nokogiri::HTML(open(site+link.css('a').first["href"]))
        page.xpath('//@style').remove
        page.xpath('//@face').remove
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
        page.css("center").remove
        page.xpath('//comment()').remove
        page.search("img").each do |img|
          img['src']=site +link.css('a').first["href"].partition("/").first + "/"+ img['src']
        end

        p page.css(css).to_s.length
        id=Digest::MD5.hexdigest(site+link.css('a').first["href"])

        File.write("material/"+id+".html", "# encoding: windows-1251\n" +page.css(css).to_s)
        csv << [id, cat, s, "2015-12-08", "2015-12-08", UnicodeUtils.downcase(s)]


      end
    }
  end
end