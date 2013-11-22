# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require "rubygems"
require "net/http"
require "uri"
require "open-uri"
require "csv"
require "json"



## LINK TO YIPU'S CASE STUDY GOOGLE SPREADSHEET
 # Initialize the client & Google+ API
test = "https://spreadsheets.google.com/feeds/cells/0AojPWc7pGzlMdDNhSXd1MW8wSmxiSkt5LXJkZDZWNEE/od6/public/basic?alt=json-in-script&callback=?"
cs_url = 'https://docs.google.com/spreadsheet/pub?key=0AjAwCuCEhsj_dHdiYW82LWJRR21mZU5aenRyRXVxa0E&single=true&gid=0&output=json'
company_url = 'https://docs.google.com/spreadsheet/pub?key=0AjAwCuCEhsj_dHdiYW82LWJRR21mZU5aenRyRXVxa0E&single=true&gid=3&output=html'


def getAPIdata(url)
	url = URI(url.to_s)

	http = Net::HTTP.new(url.host, url.port) 
	p url.request_uri 
	http.use_ssl = true
	http.verify_mode = OpenSSL::SSL::VERIFY_NONE

	request = Net::HTTP::Get.new url.request_uri  

	res = http.request request
	res = res.code == "200" ? res.body : ""#JSON.parse(res.body)['data'] : -1
	p "GET: #{url.to_s}"
	p res
	return res
end

getAPIdata(cs_url)