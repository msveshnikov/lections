require 'open-uri'
require 'nokogiri'
require 'digest/md5'
require 'csv'
require 'unicode_utils'

doc = Nokogiri::HTML(open("http://www.toehelp.ru/theory/sopromat/"))
links = doc.css(".line1bb").css("a")
p links.length

CSV.open("myfile.csv", "w") do |csv|
  CSV.open("myfile2.csv", "w") do |csv2|
    cat="sopr"

    links.each { |link|
      p link.text
      page = Nokogiri::HTML(open("http://www.toehelp.ru/theory/sopromat/"+link["href"]))
      page.xpath('//@style').remove
      page.css("a").remove
      page.css(".postmetadata").remove
      page.css(".nav").remove
      page.css(".adsbygoogle").remove
      page.css("script").remove
      page.search("img").each do |img|
        img['src']="http://www.toehelp.ru/theory/sopromat/"+ img['src']
      end
      c=page.css(".line1bb").length
      id=Digest::MD5.hexdigest(link["href"])

      if c==0
        csv2 << [id, cat, link.text, "20151120", "20151120"]
        cat=id
      else
        File.write("material/"+id+".html", "# encoding: windows-1251\n" +page.css(".line1bb").to_s)
        csv << [id, cat, link.text, "20151120", "20151120", UnicodeUtils.downcase(link.text)]
      end
    }
  end
end