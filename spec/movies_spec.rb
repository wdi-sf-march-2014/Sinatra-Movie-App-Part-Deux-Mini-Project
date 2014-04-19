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
    it "should return results for cars" do
      get '/results?movie=cars'
      last_response.should be_ok
    end
  end

 it "should return cars as a search result when it is searched for" do
      get '/results?movie=cars'
      last_response.should be_ok
      expect(last_response.body).to include("Cars")  
    end

    it "should return the year cars was made" do
      get '/results?movie=cars'
      last_response.should be_ok
      expect(last_response.body).to include("2006")
    end


		# it "should show a page when no search terms are entered" do
  #     get '/results'
  #     last_response.should be_ok
  #   end
  # end

  describe "Info page" do
    it "should return a valid page for the movie information for cars" do
      get '/movie/info/tt0317219'
      last_response.should be_ok
    end
      it "should return the cars poster" do
      get '/movie/info/tt0317219'
      expect(last_response.body).to include("http://ia.media-imdb.com/images/M/MV5BMTE5Mzk5MTA2Ml5BMl5BanBnXkFtZTYwNTY3NTc2._V1_SX300.jpg")
    end
  end

end