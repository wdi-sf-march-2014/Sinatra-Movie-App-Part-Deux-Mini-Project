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
	if params["movie"] == ""
	redirect '/'
	end

	result = Typhoeus.get("http://www.omdbapi.com/", :params => { :s => params["movie"] })  # :y => params["year"]
	response = JSON.parse(result.body)
	str = ""

	response["Search"].each do |movie|
	str += "<br><a href=poster/#{movie["imdbID"]}> #{movie["Title"]} - #{movie["Year"]} </a><br>"""
	end
		str
end
#erb :show


get '/poster/:imdbID' do
	res = Typhoeus.get("http://www.omdbapi.com/", :params => { :i => params["imdbID"] })
	pic = JSON.parse(res.body) 
	#pic.inspect
	"<img src = #{pic["Poster"]} />  #{pic["Plot"]} \n #{pic["Released Year"]}, #{pic["Rated"]}, #{pic["Runtime"]}, #{pic["Genre"]}, #{pic["Director"]}, #{pic["Actors"]}. "


end





