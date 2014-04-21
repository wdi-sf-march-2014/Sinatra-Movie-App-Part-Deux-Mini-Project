require File.expand_path '../spec_helper.rb', __FILE__

describe 'Sinatra Movie Application With OMDB API' do

  describe 'Home page' do
    it "accessing the home page" do
      get '/'
      last_response.should be_ok
    end
  end

  describe 'Results page' do
    it "should return results" do
      get '/results?movie=say+anything'
      last_response.should be_ok
    end

    it "should return Say Anything" do
      get '/results?movie=say+anything'
      last_response.should be_ok
      expect(last_response.body).to include("Say Anything...")
    end
end


  describe 'Error page' do
    it "return error page when the API doesn't return any results" do
      get '/results?movie=too+specific'
      last_response.should be_ok
    end

    it "should include an apology for not returning anything" do
      get '/results'
      last_response.should be_ok
      expect(last_response.body).to include("Sorry")
    end
  end

end