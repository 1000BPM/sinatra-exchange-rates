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

get("/:from_currency/:to_currency") do
  "test!!!!"
  @from_currency = params.fetch("from_currency")
  @to_currency = params.fetch("to_currency")

  api_url = "https://api.exchangerate.host/convert?from=#{@from_currency}&to=#{@to_currency}&amount=1&access_key=#{ENV.fetch("EXCH_KEY")}"
 
  @raw_response = HTTP.get(api_url)
  @raw_string = @raw_response.to_s

  @parsed_response = JSON.parse(@raw_string)
  @amt_converted = @parsed_response.fetch("result")
  
  erb(:convert_result)
end

# @curr_list.each do |from|
#   @from_currency = "/" + from
#   get(@from_currency) do
#   end

#   erb(:from_to_view)
  

# end
