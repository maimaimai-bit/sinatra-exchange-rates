require "sinatra"
require "sinatra/reloader"
require "http"
require "json"
require "dotenv/load"

get("/") do
  api_url = "https://api.exchangerate.host/list"
  raw_response = HTTP.get(api_url)
  parsed_data = JSON.parse(raw_response.to_s)
  
  @currencies = parsed_data["currencies"]
  
  erb(:homepage)
end

get("/:from_currency") do
  @from_currency = params.fetch("from_currency")
  
  api_url = "https://api.exchangerate.host/list"
  raw_response = HTTP.get(api_url)
  parsed_data = JSON.parse(raw_response.to_s)
  
  @currencies = parsed_data["currencies"]
  
  erb(:currency_page)
end

get("/:from_currency/:to_currency") do
  @from_currency = params.fetch("from_currency")
  @to_currency = params.fetch("to_currency")
  
  api_url = "https://api.exchangerate.host/convert?from=#{@from_currency}&to=#{@to_currency}&amount=1"
  raw_response = HTTP.get(api_url)
  parsed_data = JSON.parse(raw_response.to_s)
  
  @conversion_rate = parsed_data["result"]
  
  erb(:conversion_page)
end
