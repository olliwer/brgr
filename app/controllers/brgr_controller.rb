require 'uri'
require 'net/http'
require 'json'

class BrgrController < ApplicationController
  def show
	@location = params[:messages][:location]
	parsed_url = URI.parse('https://maps.googleapis.com/maps/api/place/radarsearch/json?' + @location + '&radius=5000&types=food&sensor=false&keyword=vegetarian&key=AIzaSyC-CNui9DmsDGjlESFKa-iK42r1x11jywc')
	http = Net::HTTP.new(parsed_url.host, parsed_url.port)
	http.use_ssl = true
	request = Net::HTTP::Get.new(parsed_url.request_uri)
	result = http.request(request)
        parsed_json = JSON.parse result.body
	@names = []
	parsed_json["results"].each do |result|
	   @names.push result["name"]
	end  
	render 'brgr'
  end

  def add
        render 'add'
  end 

end
