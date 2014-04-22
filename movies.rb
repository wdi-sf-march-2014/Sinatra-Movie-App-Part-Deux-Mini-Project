require 'sinatra'
require 'sinatra/contrib/all'
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
	if params[:movie] == ""
		redirect '/'
	else
		response = Typhoeus.get("http://www.omdbapi.com", :params => { :s => params[:movie]})
		@results = JSON.parse(response.body)["Search"]
		erb :results
	end
end

get '/detail/:imdbID' do
	response = Typhoeus.get("http://www.omdbapi.com", :params => { :i => params[:imdbID]})
	@info = JSON.parse(response.body)
	@poster = @info["Poster"]
	erb :detail
end