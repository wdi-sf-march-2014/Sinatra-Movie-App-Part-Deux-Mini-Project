require 'bundler/setup'
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

get '/results' do
	movie = params[:movie]

	if params.keys.length == 0
		erb :error
		#throws error if no params at all

	#elsif throw error if param is empty string??

	else
		response = Typhoeus.get("www.omdbapi.com", :params => {:s => movie })
		parsed_response = JSON.parse(response.body)
		all_titles = parsed_response['Search']
		all_titles_sorted = all_titles.sort_by { |hash| hash['Year'] }

		@search_results = ""

		all_titles_sorted.each do |result|
			title = result['Title'].to_s
			year = result['Year'].to_s
			imdbID = result['imdbID']
			@search_results += "<br><a href=poster/#{imdbID}> #{title} - #{year}</a><br>"
		end

		#throw error page if no results returned?

		erb :results
	end
end

get '/poster/:imdbID' do
	imdbID = params[:imdbID]

	details = Typhoeus.get("www.omdbapi.com", :params => {:i => params[:imdbID] })
	details_parsed = JSON.parse(details.body)

	poster_test = details_parsed['Poster']

	if poster_test == 'N/A'
		@poster = ''
	else
		@poster = poster_test
	end

	@title = details_parsed['Title']
	@plot = details_parsed['Plot']
	@year = details_parsed['Year']
	@rating = details_parsed['Rated']
	@runtime = details_parsed['Runtime']
	@genre = details_parsed['Genre']
	@director = details_parsed['Director']
	@actors = details_parsed['Actors']
	@moreinfo = 'http://www.imdb.com/title/'+imdbID

	erb :details

end

