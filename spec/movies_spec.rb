require File.expand_path '../spec_helper.rb', __FILE__

describe "Sinatra Movie Application With OMDB API" do

  describe "Home page" do
    it "should allow accessing the home page" do
      get '/'
      last_response.should be_ok
    end
  end

	describe "Results page" do
  	it "should return results for Say Anything..." do
      get '/results?movie=say+anything'
      last_response.should be_ok
    end

    it "should return Say Anything... as a search result when it is searched for" do
      get '/results?movie=say+anything'
      last_response.should be_ok
      expect(last_response.body).to include("Say Anything...")  
    end

    it "should return the year Say Anything... was made" do
      get '/results?movie=say+anything'
      last_response.should be_ok
      expect(last_response.body).to include("1989")
    end
  end

  describe "Details page" do
    it "should return a valid page for with movie details" do
      get '/details/tt0098258'
      last_response.should be_ok
    end

    it "should include the Say Anything... poster" do
      get '/details/tt0098258'
      expect(last_response.body).to include("http://ia.media-imdb.com/images/M/MV5BMTg5OTk1NjczNl5BMl5BanBnXkFtZTgwNTE3NjkzMTE@._V1_SX300.jpg")
    end

    it "should link to the IMDb page for Say Anything..." do
  		get '/details/tt0098258'
      expect(last_response.body).to include("http://www.imdb.com/title/tt0098258")
  	end

  	it "should include the film rating" do
  		get '/details/tt0098258'
  		expect(last_response.body).to include("PG-13")
  	end    
  end

	describe "Error page" do
  	it "should show an error page when the API doesn't return any results" do
    	get '/results?movie=too+specific'
      last_response.should be_ok
    end

    it "should include an apology for not returning anything" do
    	get '/results'
    	last_response.should be_ok
    	expect(last_response.body).to include("Sorry")
    end
  end

end