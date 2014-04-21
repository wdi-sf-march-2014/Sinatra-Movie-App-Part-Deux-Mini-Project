require 'bundler/setup'
require 'sinatra'
require 'sinatra/reloader'
require 'typhoeus'
require 'json'
require 'pry'

configure do
  root = File.expand_path(File.dirname(__FILE__))
  set :views, File.join(root,'views')
end

get '/' do
@page_title = "Flixter"
erb :search
end

get '/results' do
search = params[:movie]
if search == "" || search == nil
return "Movie not found"
end

response = Typhoeus.get("http://www.omdbapi.com/?s=#{search}")
results = JSON.parse(response.body)
results.inspect 
@movies = results["Search"]
erb :index
end

get '/poster/:imdbID' do
  search = params[:imdbID]
  response = Typhoeus.get("http://www.omdbapi.com/?i=#{search}")
  @picture = JSON.parse(response.body)
  @poster = @picture['Poster']
  @plot = @picture['Plot']
  @type = @picture['Type']
  @votes = @picture['imdbVotes']
  @release = @picture['Released']
  @rated = @picture['Rated']
  @runtime = @picture['Runtime']
  @genre = @picture['Genre']
  @director = @picture['Director']
  @actor = @picture['Actors']
  erb :show
end


# @movies = []
# @data.each do |h|
# @movies.push "<li>#{h["Title"]} - #{h["Year"]}</li><br></br>"
# end
# return @movies

