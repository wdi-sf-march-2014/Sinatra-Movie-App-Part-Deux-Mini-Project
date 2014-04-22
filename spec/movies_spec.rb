require File.expand_path '../spec_helper.rb', __FILE__

describe "Sinatra Movie Application With OMDB API" do

  describe "Home page" do
    it "should allow accessing the home page" do
      get '/'
      last_response.should be_ok
    end
  end

  describe "Results Page" do
  	it "should return results for twister" do
  		get '/results?movie=twister'
  		last_response.should be_ok
  	end

  	it "should show a page when no search terms are entered" do
  		get '/results'
  		last_response.should be_ok
  	end

  	it "should return results when a multi word movie title is searched" do
  		get '/results?movie=the+mighty+ducks'
  		last_response.should be_ok 
  		expect(last_response.body).to include('The Mighty Ducks')
  	end
  end
  
  describe "Detail Page" do
  	it "should return a valid page for the twister poster" do
  		get '/detail/tt0117998'
  		last_response.should be_ok
  	end
  	it "should return the twister poster" do
      get '/detail/tt0117998'
      expect(last_response.body).to include("http://ia.media-imdb.com/images/M/MV5BMjE3NDMzODA2M15BMl5BanBnXkFtZTcwMDA5MDkxMQ@@._V1_SX300.jpg")
    end
  end
end
