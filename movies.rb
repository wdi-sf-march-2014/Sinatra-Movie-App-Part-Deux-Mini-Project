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

get "/" do

erb :index
end
  
get '/search' do
 	search_str = params[:movie]
 	response = Typhoeus.get("http://www.omdbapi.com/", :params => {:s => search_str})
 	omdbdata = JSON.parse(response.body)
 	@movies = omdbdata["Search"]
 erb :search
 end
 

get '/movies/:imdbID' do
 	imdb_id = params[:imdbID]
 	info = Typhoeus.get("http://www.omdbapi.com/", :params => {:i => imdb_id})
 	infodata = JSON.parse(info.body)
 	@plot = infodata["Plot"]
 	@year = infodata["Year"]
 	@rated = infodata["Rated"]
 	@runtime = infodata["Runtime"]
 	@genre = infodata["Genre"]
 	@director =infodata["Director"]
 	@actors = infodata["Actors"]
 	@poster = infodata["Poster"]
 	@title = infodata["Title"]
 	@link = infodata["imdbID"]
 erb :show
 end