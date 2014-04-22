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

################ 

get '/' do

	erb :index
end

get '/results' do
	if params[:movie] == ""
		erb :index

		# get '/results' do

		# 	erb :index
		# end

	else
		search = params[:movie]
		search = search.gsub(/\s/, "%20")
		results= Typhoeus.get("www.omdbapi.com/?s=#{search}")
		@omdb_data = JSON.parse(results.body)
		erb :search
	end
end

get '/poster/:imdbID' do
	results = Typhoeus.get("http://www.omdbapi.com/?i=#{params[:imdbID]}")
  	@movie_data = JSON.parse(results.body)
  	erb :show
end

