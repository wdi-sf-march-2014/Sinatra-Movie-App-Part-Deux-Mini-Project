require 'sinatra'
require 'sinatra/reloader'
require 'typhoeus'
require 'json'
require 'pry'

get '/' do
	erb :index
end

get '/show' do
	search = Typhoeus.get("www.omdbapi.com/", :params => {:s => params[:movie]})
	@result = JSON.parse(search.body)["Search"]
	erb :show
end

get '/movie_info/:imdbID' do
	search = Typhoeus.get("www.omdbapi.com/", :params => {:i => params["imdbID"]})
	@result2 = JSON.parse(search.body)
	erb :movie_info
end
