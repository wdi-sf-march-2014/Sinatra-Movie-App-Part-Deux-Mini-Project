require 'sinatra'
require 'sinatra/reloader'
require 'typhoeus'
require 'json'
require 'pry'

configure do
  root = File.expand_path(File.dirname(__FILE__))
  set :views, File.join(root,'views')
end

get '/' do
 
erb:search
end

get '/results' do
  if params["movie"] == ""
  redirect "/"
end
  res = Typhoeus.get("www.omdbapi.com/", 
  :params => { :s => params["movie"]}) 
  @movies = JSON.parse(res.body)["Search"]
   
   erb :index
end

get '/movie/:imdbID' do

  res=Typhoeus.get("www.omdbapi.com/", 
    :params => { :i => params["imdbID"] })
  @pic = JSON.parse(res.body)
  # @temp = pic.inspect
  


erb :show
end




# # A setup step to get rspec tests running.
# configure do
#   root = File.expand_path(File.dirname(__FILE__))
#   set :views, File.join(root,'views')
# end

# get '/' do
#   erb:search
# end


# get '/results' do
  
#   res=Typhoeus.get("www.omdbapi.com/", :params => { :s => params["movie"] }) 
#   json = JSON.parse(res.body) 
#   str = ""
   
  
#   json["Search"].each do |movie|
    
#   # erb:index
#   end
  
  

# end

# get '/poster/:imdbID' do
#   res=Typhoeus.get("www.omdbapi.com/", :params => { :i => params["imdbID"] })
#   pic = JSON.parse(res.body) 
#   #"<img src = #{pic["Poster"]} />"
# erb :show
# end

