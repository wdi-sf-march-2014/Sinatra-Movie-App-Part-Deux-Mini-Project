require 'sinatra'
require 'sinatra/reloader'
require 'typhoeus'
require 'json'
require 'pry'

get '/' do
	@method = "get"
	@action = "/show"
	erb :index
end

get '/show' do
	search = Typhoeus.get("www.omdbapi.com/", :params => {:s => params[:movie]})
	@result = JSON.parse(search.body)["Search"]
		# puts result["Search"]
		# puts @result
		 # @title = @result["Title"]
		 # @year = @result["Year"]
		 # @id = @result["imdbID"]
		 # @rated = @result["Rated"]
		 # @actors = @result["Actors"]
		 # @plot = @result["Plot"]

	# 	 search2 = Typhoeus.get("www.omdbapi.com", :params => {:i => id})
	# 	 result2 = JSON.parse(search2.body)
	# 	 @poster = result2["Poster"]
	# @greeting = "Hello"
	# @show = "Hello"
	erb :show
end

get '/movie_info/:imdbID' do
	search = Typhoeus.get("www.omdbapi.com/", :params => {:i => params["imdbID"]})
	@poster = JSON.parse(search.body)
	erb :movie_info
	

	# @year = info["Year"]
	# @id = info["imdbID"]
	# @rated = @result["Rated"]
	# @actors = @result["Actors"]
	# @plot = @result["Plot"]

end
