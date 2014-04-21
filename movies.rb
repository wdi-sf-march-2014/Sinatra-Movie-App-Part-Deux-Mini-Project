require 'bundler/setup'
require 'sinatra'
require 'sinatra/reloader'
require 'typhoeus'
require 'json'
require 'pry'

configure do
  root = File.expand_path(File.dirname(__FILE__))
  set :views, File.join(root, 'views')
end

get '/' do
  erb :index
end

get '/results' do
  movie = params[:movie]

  if params.keys.length == 0
    erb :error

  elsif movie == ''
    erb :error

  else
    response = Typhoeus.get('www.omdbapi.com', :params => {:s => movie })
    movie_data = JSON.parse(response.body)

    if movie_data.key?('Search') == false
      erb :error

    else

      all_titles = movie_data['Search']
      all_titles_sorted = all_titles.sort_by { |hash| hash['Year'] }

      @title = []
      @year = []
      @imdbID = []

      all_titles_sorted.each do |x|
        @title << x['Title'].to_s
        @year << x['Year'].to_s
        @imdbID << x['imdbID']
      end

      erb :results

    end
  end
end
get '/details/:imdbID' do
  imdbID = params[:imdbID]

  details = Typhoeus.get("www.omdbapi.com", :params => {:i => params[:imdbID] })
  imdbID_details = JSON.parse(details.body)

  poster_test = imdbID_details['Poster']

  if poster_test == 'N/A'
    erb :image_error
  else
    @poster = poster_test
  end

  @title = imdbID_details['Title']
  @plot = imdbID_details['Plot']
  @year = imdbID_details['Year']
  @rating = imdbID_details['Rated']
  @runtime = imdbID_details['Runtime']
  @genre = imdbID_details['Genre']
  @director = imdbID_details['Director']
  @actors = imdbID_details['Actors']
  @moreinfo = 'http://www.imdb.com/title/' + imdbID

  erb :details

end


