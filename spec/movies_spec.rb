require File.expand_path '../spec_helper.rb', __FILE__

describe "Sinatra Movie Application With OMDB API" do

  describe "Home page" do
    it "should allow accessing the home page" do
      get '/'
      last_response.should be_ok
    end
  end

  describe "Home page" do
    it "should allow accessing the home page" do
      get '/'
      last_response.should be_ok
    end
  end

  describe "Search Results" do
    it "should return results for the jungle book" do
      get '/results?movie=the+jungle+book'
      last_response.should be_ok
    end
	end

  describe "Info page" do
    it "should return a valid page for the jungle book poster" do
      get '/info/tt0061852'
      last_response.should be_ok
    end
  end
end


