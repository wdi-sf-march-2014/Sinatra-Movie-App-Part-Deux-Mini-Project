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
	erb :search 
end

get '/results' do
	# if params["movie"] == ""
	# redirect '/'
	# end

	result = Typhoeus.get("http://www.omdbapi.com/", :params => { :s => params["movie"] })  # :y => params["year"]
	response = JSON.parse(result.body)
    
    @movies = response["Search"]

    erb :index

end


get '/poster/:imdbID' do
	res = Typhoeus.get("http://www.omdbapi.com/", :params => { :i => params["imdbID"] })
	@pic = JSON.parse(res.body) 

	erb :show
end


