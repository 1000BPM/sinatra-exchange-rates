require "sinatra"
require "sinatra/reloader"

require "http"
require "dotenv/load"

get("/") do
  api_url = "https://api.exchangerate.host/list?access_key=#{ENV.fetch("EXCH_KEY")}"
 
  @raw_response = HTTP.get(api_url)
  @raw_string = @raw_response.to_s

  @parsed_response = JSON.parse(@raw_string)
  @curr = @parsed_response.fetch("currencies")
  @curr_list = @curr.keys

  
  #@curr_response = @raw_string.fetch("currencies")

  erb(:homepage)
  
end

get("/:from_currency") do
  
  @from_currency = params.fetch("from_currency")

  api_url = "https://api.exchangerate.host/list?access_key=#{ENV.fetch("EXCH_KEY")}"
 
  @raw_response = HTTP.get(api_url)
  @raw_string = @raw_response.to_s

  @parsed_response = JSON.parse(@raw_string)
  @curr = @parsed_response.fetch("currencies")
  @curr_list = @curr.keys

  
  erb(:from_to_view)
end

# @curr_list.each do |from|
#   @from_currency = "/" + from
#   get(@from_currency) do
#   end

#   erb(:from_to_view)
  

# end
