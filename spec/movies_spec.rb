require File.expand_path '../spec_helper.rb', __FILE__

  describe "Sinatra Movie Application With OMDB API" do

  describe "Home page" do
    it "should allow accessing the home page" do
      get '/'
      last_response.should be_ok
    end
  end

    it "should return the year jaws was made" do
      get '/results?movie=jaws'
      last_response.should be_ok
      expect(last_response.body).to include("1975")
    end
 
    it "should return the poster" do
    get '/results?Poster=results'
    last_response.should be_ok
    expect(last_response.body).to include("results")
    end

    # it "should show this page when no search terms are entered" do
    #   get "/"
    #   last_response.should be_ok
    # end
end
