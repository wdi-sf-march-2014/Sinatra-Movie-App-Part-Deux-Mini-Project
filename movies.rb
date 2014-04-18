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
	# redirect to('/results')
erb :search
end

get '/results' do
	# redirect to('/poster')
	search = params[:movie].gsub(" ", "+")
	results= Typhoeus.get("www.omdbapi.com/?s=#{search}")
	ombd_data = JSON.parse(results.body)
	# ombd_data.inspect
erb :index
@movies=ombd_data.to_s


# if ombd_data["Search"] == nil
# 	 "<h1>Sorry, we could not find that title. Try again.</h1>"
# else
# 	ombd_data["Search"].each do |h|
# 	# "<a href='/poster/#{h["imdbID"]}'><li>#{h["Title"]} - #{h["Year"]}<br></br></li></a>"
# 	end
# end

end

get '/poster/:imdbID' do
	search = params[:imbdID]
	results = Typhoeus.get("http://www.omdbapi.com/?i=#{params[:imdbID]}")
  ombd_data = JSON.parse(results.body)

erb :show
end

