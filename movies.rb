
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

	erb:search
end


get '/results' do

	search = params[:movie].gsub(" ", "+")
	# if search == "" || search == nil
	# 	return "This movie does not exist"
	# end

		results= Typhoeus.get("http://www.omdbapi.com/?s=#{search}")
		omdb_data = JSON.parse(results.body)
		@movies=omdb_data["Search"]
	erb :index
end

get '/poster/:imdbID' do

	imdb_id = params[:imdbID]

	new_results = Typhoeus.get("www.omdbapi.com/?i=#{imdb_id}")
	@imdb_poster= JSON.parse(new_results.body)

	
	
	erb :show
end



