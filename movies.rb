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
	@movies = JSON.parse(Typhoeus.get("http://www.omdbapi.com/?s=" + params[:movie]).body)["Search"]
	@movies = @movies.sort_by {|movie| movie["Year"].to_i}
	if @movies == nil
		erb :index
	# TODO: for multi words strings that doesn't exist the code breaks e.g. "lasdf asd"
	# make comment about movie non-existence before returning to Homepage		
	else
		erb :search
	end
end

get '/poster/:imdbID' do
	@posterDetail = JSON.parse(Typhoeus.get("http://www.omdbapi.com/?i=" + params[:imdbID]).body)
	erb :show
end
