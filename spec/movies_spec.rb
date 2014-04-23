require File.expand_path '../spec_helper.rb', __FILE__

describe "Sinatra Movie Application With OMDB API" do

  describe "Home page" do
    it "should allow accessing the home page" do
      get '/'
      last_response.should be_ok
    end
#is this correct?
  describe "Results Page" do
    it "should display movies matchin search terms" do
    	get '/results'
    	last_response.should be_ok
    	expect(last_response.body).to include ("movie")
    end
end