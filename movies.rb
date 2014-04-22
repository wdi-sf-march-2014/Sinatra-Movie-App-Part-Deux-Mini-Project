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
erb:index

end



get '/results' do



	#Gets JSON information and display in results page.
search = params[:movie]

if search == "" || search == nil
	return "You broke it"
end	

results = Typhoeus.get("www.omdbapi.com/?s=#{search}")
@omdb_data = JSON.parse(results.body)
#@omdb_data.inspect
erb:search

end


get '/results/:imdbID' do
  
  imdbID = params[:imdbID]
  request = Typhoeus.get("http://www.omdbapi.com?i=#{imdbID}")

  @movie_info = JSON.parse(request.body)
  

  erb :show
  	
 end


