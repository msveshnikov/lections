require "rubygems"
require "json"
require 'csv'

file = open("base.json")
json = file.read

parsed = JSON.parse(json)

CSV.open("myfile.csv", "w") do |csv|
CSV.open("myfile2.csv", "w") do |csv2|

parsed["data"].each { |key, value|
	if parsed["data"][key]["mSubcategoriesList"]["size"]>0 
        p parsed["data"][key]["mName"], parsed["data"][key]["mSubcategoriesList"]["size"]
	  	parsed["data"][key]["mSubcategoriesList"]["data"].each do |shop|
 		  p "       "+shop["mName"]
 		  csv2 << [shop["mId"],key,  shop["mName"],"20151010","20151010"]
		end
	end
    if parsed["data"][key]["mMaterialsList"]["size"]>0
	    p parsed["data"][key]["mName"], parsed["data"][key]["mMaterialsList"]["size"]
	  	parsed["data"][key]["mMaterialsList"]["data"].each do |shop|
 		  p "            "+shop["mName"]
 		  csv << [shop["mId"],key,  shop["mName"],"20151010","20151010"]
		end
	end
}

end
end