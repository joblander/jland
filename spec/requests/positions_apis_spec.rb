require 'spec_helper'

describe "PositionsApis" do
  describe "GET  /users/:user_id/positions.json" do
    it "gets all positions" do
      user = Factory(:user)
      get "/users/#{user.id}/positions.json"
      response.status.should be(200)
    end
  end
end
