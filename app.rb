require 'bundler/setup'
require 'sinatra'
require 'sinatra/reloader'
require 'typhoeus'
require 'json'
require 'erb'

get '/' do
	erb :index
end

get '/result' do
	search_string = params[:movie]
	search = Typhoeus.get("www.omdbapi.com/", :params => {:s => search_string})
	result = JSON.parse(search.body)
		# puts result["Search"]
		 @title = instance["Title"] 
		 @year = instance["Year"]
		 @id = instance["imdbID"]
		 # search = Typhoeus.get("www.omdbapi.com", :params => {:i => id})
		 # result2 = JSON.parse(search.body)
		 # @poster = result2["Poster"]
		 erb :show
end
