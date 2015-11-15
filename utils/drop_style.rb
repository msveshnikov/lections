require 'nokogiri'

Dir.foreach('.') do |item|
  next if item == '.' or item == '..'
  p item
  html = File.read(item)
  doc = Nokogiri::HTML(html)
  doc.xpath('//@style').remove
  File.write(item, doc)
end


