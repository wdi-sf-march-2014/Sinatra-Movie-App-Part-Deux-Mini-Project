require 'bundler/setup'
require 'sinatra'
require 'sinatra/reloader'
require 'typhoeus'
require 'json'
require 'rubygems'

configure do
  root = File.expand_path(File.dirname(__FILE__))
  set :views, File.join(root,'views')
end

get '/' do
  erb :index
end

get '/results' do
  search = params[:movie].gsub(" ", "+")

  results = Typhoeus.get("http://www.omdbapi.com/?s=#{search}")
  omdb_data = JSON.parse(results.body)
  @movies = omdb_data["Search"]
  # validation if search result == nil
  if @movies == nil
    redirect '/'
  end

  erb :search
end

get '/poster/:imdbID' do
  @search = params[:imdbID]
  res = Typhoeus.get("http://www.omdbapi.com/?i=#{@search}")
  @picture = JSON.parse(res.body)

  @poster = @picture["Poster"]
  @plot = @picture["Plot"]
  @release = @picture["Released"]
  @rated = @picture["Rated"]
  @runtime = @picture["Runtime"]
  @genre = @picture["Genre"]
  @director = @picture["Director"]
  @actor = @picture["Actors"]
  erb :poster
end
