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
	# redirect to('/poster')
	search = params[:movie].gsub(" ", "+")
	results= Typhoeus.get("www.omdbapi.com/?s=#{search}")
	ombd_data = JSON.parse(results.body)
	# ombd_data.inspect

	@movies=ombd_data["Search"]

	erb :index
end


get '/poster/:imdbID' do
	search = params[:imbdID]
	results = Typhoeus.get("http://www.omdbapi.com/?i=#{params[:imdbID]}")
  ombd_data = JSON.parse(results.body)

erb :show
end

