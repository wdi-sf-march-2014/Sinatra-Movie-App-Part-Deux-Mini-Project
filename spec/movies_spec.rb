require File.expand_path '../spec_helper.rb', __FILE__

describe "Sinatra Movie Application With OMDB API" do

  describe "Home page" do
    it "should allow accessing the home page" do
      get '/'
      last_response.should be_ok
    end
  end

  describe "Results page" do
  	it "should allow accessing to the search page" do
  		get '/results'
  		last_response.should be_ok
  	end
    it "should return results for jaws" do
      get '/results?movie=jaws'
      last_response.should be_ok
    end
    it "should return the year sharknado was made" do
       get '/results?movie=jaws'
       last_response.should be_ok
      expect(last_response.body).to include("1975")
     end
  end

  describe "Poster page" do
    it "should return a valid page for the sharknado poster" do
      get '/poster/tt2724064'
      last_response.should be_ok
    end 
  end
end

    
    


