require File.expand_path '../spec_helper.rb', __FILE__

describe "Sinatra Movie Application With OMDB API" do

	  describe "Home page" do
	    it "should allow accessing the home page" do
	      get '/'
	      last_response.should be_ok
	    end
	  end

	  

	  describe "Search Results" do
	    it "should return results for Forbidden Planet" do
	      get '/results?movie=Forbidden%20Planet'
	      last_response.should be_ok
	    end

	    # it "should show a page when no search terms are entered" do
	    #   get '/results'
	    #   last_response.should be_ok
	    # end

	    it "should return Forbidden Planet as a search result when it is searched for" do
	      get '/results?movie=Forbidden%20Planet'
	      last_response.should be_ok
	      expect(last_response.body).to include("Forbidden Planet")  
	    end

	    it "should return the year Forbidden Planet was made" do
	      get '/results?movie=Forbidden%20Planet'
	      last_response.should be_ok
	      expect(last_response.body).to include("1956")
	    end

	    it "should return the Director of Forbidden Planet" do
	      get '/poster/tt0049223'
	      last_response.should be_ok
	      expect(last_response.body).to include("Fred M. Wilcox")
	    end

	    it "should return the runtime of Forbidden Planet" do
	    	get '/poster/tt0049223'
	    	last_response.should be_ok
	    	expect(last_response.body).to include("98 min")
	    end
	end
end
