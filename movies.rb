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
	erb :search
end

get '/results' do
	search = params[:movie].gsub(" ", "+")
	results= Typhoeus.get("www.omdbapi.com/?s=#{search}")
	omdb_data = JSON.parse(results.body)

	movies=omdb_data["Search"]
	@movies_with_posters=movies.map do |movie|
		movie_with_poster = Typhoeus.get("http://www.omdbapi.com/?i=#{movie['imdbID']}")
		JSON.parse(movie_with_poster.body)	
	end

	erb :index
end

get '/info/:imdbID' do
	search = params[:imbdID]
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
