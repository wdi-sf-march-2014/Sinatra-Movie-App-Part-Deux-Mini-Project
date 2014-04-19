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

	
get '/search' do	
	# binding.pry
 	search = Typhoeus.get("www.omdbapi.com", :params => {:s => params[:movie]})
 	result = JSON.parse(search.body)
 	@movies = result["Search"]

	erb :search
	end

get '/show/:id' do
	# binding.pry
	search = Typhoeus.get("www.omdbapi.com", :params => {:i => params[:id]})
	@movie= JSON.parse(search.body)
	erb :show
	end


# <%= search = Typhoeus.get("www.omdbapi.com", :params => {:i => id}) %>
# <%= result2 = JSON.parse(search.body) %>
# <%= poster = result2["Poster"] %>