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
	@image_url = "http://thumbpress.com/wp-content/uploads/2011/11/chewbacca-wink.gif"
	erb :index
end

get '/results' do
	search = params[:movie].gsub(" ", "+")
	results = Typhoeus.get("www.omdbapi.com/?s=#{search}")
	@omdb_data = JSON.parse(results.body)
	@omdb_data = @omdb_data["Search"]
	@omdb_data.inspect
	if @omdb_data == nil
		erb :error
	else
		erb :search
	end
	#@omdb_data.inspect
end

get '/poster/:imdbID' do
	search = params[:imbdID]
	results = Typhoeus.get("http://www.omdbapi.com/?i=#{params[:imdbID]}")
  @omdb_data = JSON.parse(results.body)

  @poster = @omdb_data["Poster"]
	@plot = @omdb_data["Plot"]
	@released = @omdb_data["Released Year"]
	@rated = @omdb_data["Rated"]
	@runtime = @omdb_data["Runtime"]
	@genre = @omdb_data["Genre"]
	@director = @omdb_data["Director"]
	@actors = @omdb_data["Actors"]
  erb :show
end


