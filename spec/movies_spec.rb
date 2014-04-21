require File.expand_path '../spec_helper.rb', __FILE__

describe "Sinatra Movie Application With OMDB API" do

  describe "Home page" do
    it "should allow accessing the home page" do
      get '/'
      last_response.should be_ok
    end
  end
  describe "Search Results" do
  	it "should return results for frozen" do
  		get '/results?movie=frozen'
  		last_response.should be_ok
   end		
    it "should show a page when no search terms are entered" do
      get '/results'
      last_response.should be_ok
    end  
    it "should return frozen as a search result when it is searched for" do
      get '/results?movie=frozen'
      last_response.should be_ok
      expect(last_response.body).to include("Frozen")
    end
    it "should return the year frozen was made" do
      get '/results?movie=frozen'
      last_response.should be_ok
      expect(last_response.body).to include("2013")
    end
  end


end
