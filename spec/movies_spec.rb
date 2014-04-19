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
  end


end
