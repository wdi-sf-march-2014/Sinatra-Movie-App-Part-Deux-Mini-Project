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
#<type="submit" value="search">

erb :index
end



get '/results' do

# if result
#  erb :index
#  else
# search = params[:movie]

 #  if params[:movie] == nil|| params[:movie]==''
  	
 # 	erb :index
 # else



response = Typhoeus.get("http://www.omdbapi.com/", :params => {:s => params[:movie]})
result = JSON.parse(response.body)
@movies = result["Search"]	#Search comes from the omdbapi website
#  must use instance variables to transfer to the view 
# result["Search"].each do |movie|

# 	

# 	#Search comes from the omdbapi website
#    str += "<br><a href=/poster/#{movie["imdbID"]}> #{movie["Title"]} - #{movie["Year"]} </a><br>"
#  end
#   strif name == nil
# 	erb :index
# end
erb :search
 # end 
end

# TODO: Add another get here for the poster url. The path for the poster
# should look like this example '/poster/tt2724064'

get '/poster/:imdb_id' do
response = Typhoeus.get("http://www.omdbapi.com/", :params => {:i => params[:imdb_id]})
@result = JSON.parse(response.body)
@poster=@result["Poster"]

erb :show

#{}"<h1>Poster Page</h1><img src = #{result['Poster']}></img>"
 end






