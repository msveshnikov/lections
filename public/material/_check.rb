<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" "http://www.w3.org/TR/REC-html40/loose.dtd">
<html><body><p>require 'nokogiri'

Dir.foreach('.') do |item|
  next if item == '.' or item == '..'
  p item
  html = File.read(item)
  doc = Nokogiri::HTML(html)
  doc.xpath('//@style').remove
  File.write(item, doc)
end


</p></body></html>
