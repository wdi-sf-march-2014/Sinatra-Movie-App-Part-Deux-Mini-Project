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

  erb :index
end



get '/search' do
  if params["movie"] == ""
    redirect '/search'
  end
  response = Typhoeus.get("http://www.omdbapi.com/",:params => {:s => params[:movie]})
  @result1 = JSON.parse(response.body)
  @movies = @result1["Search"]

  erb :search

end


get '/show/:imdbID' do

  response = Typhoeus.get("http://www.omdbapi.com/",:params => {:i => params["imdbID"]})
  @result2 = JSON.parse(response.body)
  @picture = @result2["Poster"]
  
erb :show

end

