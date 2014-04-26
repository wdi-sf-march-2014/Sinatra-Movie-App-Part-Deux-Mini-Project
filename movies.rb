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
	erb :index
end


get '/results' do
	response = Typhoeus.get("http://www.omdbapi.com/", :params => {:s => params[:movie]})
	result = JSON.parse(response.body)
	@movies = result["Search"]	
	erb :search
end


get '/poster/:imdb_id' do
	response = Typhoeus.get("http://www.omdbapi.com/", :params => {:i => params[:imdb_id]})
	@result = JSON.parse(response.body)
	@poster=@result["Poster"]
	erb :show
end






