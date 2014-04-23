require File.expand_path '../spec_helper.rb', __FILE__

describe "Sinatra Movie Application With OMDB API" do

  describe "Home page" do
    it "should allow accessing the home page" do
      get '/'
      last_response.should be_ok
    end
  end

  describe "Search results" do
    it "should return results for matrix" do
      get '/results?movie=matrix'
      last_response.should be_ok
    end
  end

  describe "poster page" do
    it "should show poster for matrix" do
      get '/poster/tt0133093'
      last_response.should be_ok
    end
  end
  
end
