require File.expand_path '../spec_helper.rb', __FILE__

describe "Sinatra Movie Application With OMDB API" do

  describe "Home page" do
    it "should allow accessing the home page" do
      get '/'
      last_response.should be_ok
    end
  end
  describe "Search" do
  	it "should move you to the movie page" do
  	get '/results?movie=@movies'
  	 last_response.should be_ok
  	end
  end

  describe "poster" do
  	it "should show the movie poster" do
  		get '/poster/@imdb_poster'
  		last_response.should be_ok
  	end
  end

  describe "Title" do
  	it "should show the movie title" do
  		get '/poster/@imdb_poster'
  		last_response.should be_ok
  	end
  end
  

end
