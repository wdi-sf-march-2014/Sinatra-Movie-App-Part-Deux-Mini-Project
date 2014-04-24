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
	erb :form
end

get '/results' do
	response = Typhoeus.get("http://www.omdbapi.com/", :params => {:s => params[:movie]})
	@result = JSON.parse(response.body)
	erb :results
end

get '/poster/:imdbid' do 
	response = Typhoeus.get("http://www.omdbapi.com/", :params => {:i => params[:imdbid]})
	@post_result = JSON.parse(response.body)
	erb :poster
end
