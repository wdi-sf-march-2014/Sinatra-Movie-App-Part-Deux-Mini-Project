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
  	it "should return results for sharknado" do
  		get '/result?movie=sharknado'
  		last_response.should be_ok
  	end

  	it "should return the year sharknado was made" do
  		get '/result?movie=sharknado'
  		last_response.should be_ok
  		expect(last_response.body).to include("2013")
  	end
  end
end

