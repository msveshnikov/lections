require 'open-uri'
require 'nokogiri'
require 'digest/md5'
require 'csv'
require 'unicode_utils'

doc = Nokogiri::HTML(open("http://abc.vvsu.ru/Books/l_matemk1/"))
links = doc.css(".CONTENT").css("a")
p links.length

CSV.open("myfile.csv", "w") do |csv|
  CSV.open("myfile2.csv", "w") do |csv2|
    cat="math"

    links.each { |link|
      p link.text
      page = Nokogiri::HTML(open("http://abc.vvsu.ru/Books/l_matemk1/"+link["href"]))
      page.xpath('//@style').remove
      page.css("a").remove
      page.css(".postmetadata").remove
      page.css(".nav").remove
      page.css(".adsbygoogle").remove
      page.css("script").remove
      page.search("img").each do |img|
        img['src']="http://abc.vvsu.ru/Books/l_matemk1/"+ img['src']
      end
      c=page.css(".CONTENT").length
      id=Digest::MD5.hexdigest(link["href"])

      if c==0
        csv2 << [id, cat, link.text, "20151120", "20151120"]
        cat=id
      else
        File.write("material/"+id+".html", "# encoding: windows-1251\n" +page.css(".CONTENT").to_s)
        csv << [id, cat, link.text, "20151120", "20151120", UnicodeUtils.downcase(link.text)]
      end
    }
  end
end