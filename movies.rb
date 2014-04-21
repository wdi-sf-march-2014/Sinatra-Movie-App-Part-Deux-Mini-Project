require 'sinatra'
require 'sinatra/reloader'
require 'typhoeus'
require 'json'

configure do
  root = File.expand_path(File.dirname(__FILE__))
  set :views, File.join(root, 'views')
end


get '/' do
# redirect to form to get movie

  @method = "get"
  @action   = "/movie"

  erb :form
end

get '/movie' do

request = Typhoeus.get(
  "http://www.omdbapi.com",
  :params => { :s => params[:query]}
  )

  @movies = JSON.parse(request.body)["Search"]
  @movies = @movies.sort_by {|element| element["Year"]}
  @movies = @movies.reverse


  @movie_info_index = {}  
  @movies.each do |element|

    request2 = Typhoeus.get(
      "http://www.omdbapi.com",
      :params => { :i => element["imdbID"], :tomatoes => true}
      )
    request3 = JSON.parse(request2.body)
    @movie_info_index[element["imdbID"].to_s] = request3

  end
  erb :index
end

get "/movie/:id" do
  # show a particular movie
  @id = params[:captures][0]

  request = Typhoeus.get(
    "http://www.omdbapi.com",
    :params => { :i => @id, :tomatoes => true}
    )

  @movie_info = JSON.parse(request.body)
  #raise @movie_info.inspect
  #puts "NEW STRING http://api.rottentomatoes.com/api/public/v1.0/movie_alias.json?apikey=544r4dehy8m4bp5h4xtuzvd6&type=imdb&id=#{@id[2..-1]}"
  request_tomatoes = Typhoeus.get("http://api.rottentomatoes.com/api/public/v1.0/movie_alias.json?apikey=544r4dehy8m4bp5h4xtuzvd6&type=imdb&id=#{@id[2..-1]}")
  @tomatoes_data = JSON.parse(request_tomatoes.body)
 
  erb :movie_view
end


