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

    describe "Show Page" do 
      it "should allow access to the show page" do 
        get '/show'
        last_response.should be_ok
      end
    end
  end

  
end
