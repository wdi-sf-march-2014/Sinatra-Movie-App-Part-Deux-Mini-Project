require File.expand_path '../spec_helper.rb', __FILE__

describe "Sinatra Movie Application With OMDB API" do
	def app
    Sinatra::Application
  end

  describe "Home page" do
    it "should allow accessing the home page" do
      get '/'
      last_response.should be_ok
    end
  end

 describe "Search Results" do
    it "should return results for mulan" do
      get '/results?movie=mulan'
      last_response.should be_ok
    end
  end

  it "should return mulan as a search result when it is searched for" do
      get '/results?movie=mulan'
      last_response.should be_ok
      expect(last_response.body).to include("Mulan")  
    end

    it "should return the year mulan was made" do
      get '/results?movie=mulan'
      last_response.should be_ok
      expect(last_response.body).to include("1998")
    end
end
    # it "should show a page when no search terms are entered" do
    #   get '/results'
    #   last_response.should be_ok
    # end 
# end

 describe "Poster page" do
    it "should return a valid page for the mulan poster" do
      get '/poster/tt0120762'
      last_response.should be_ok
    end
 
    it "should return the mulan poster" do
      get '/poster/tt0120762'
      expect(last_response.body).to include("http://ia.media-imdb.com/images/M/MV5BMTIwNjY4NDU2NF5BMl5BanBnXkFtZTcwMzM0OTUyMQ@@._V1_SX300.jpg")
    end
end