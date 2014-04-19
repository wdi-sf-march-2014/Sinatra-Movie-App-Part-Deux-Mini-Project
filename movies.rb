require 'sinatra'
require 'sinatra/reloader'
require 'typhoeus'
require 'json'
require 'pry'

# A setup step to get rspec tests running.
configure do
  root = File.expand_path(File.dirname(__FILE__))
  set :views, File.join(root,'views')
end

get '/' do
	# redirect to('/results')
erb :search
end

get '/results' do
	search = params[:movie].gsub(" ", "+")
	results= Typhoeus.get("www.omdbapi.com/?s=#{search}")
	omdb_data = JSON.parse(results.body)

	@movies=omdb_data["Search"]

	erb :index
end


get '/movie/info/:imdbID' do
	search = params[:imdbID]
	results = Typhoeus.get("http://www.omdbapi.com/?i=#{params[:imdbID]}")
  omdb_data = JSON.parse(results.body)

 @poster=omdb_data["Poster"]
 @rating=omdb_data["Rated"]
 @release=omdb_data["Released"]
 @runtime=omdb_data["Runtime"]
 @genre=omdb_data["Genre"]
 @director=omdb_data["Director"]
 @actors=omdb_data["Actors"]
 @plot=omdb_data["Plot"]

erb :show
end

