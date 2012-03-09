require 'spec_helper'
require 'json'

describe "PositionsApis" do

  before do
    @user = FactoryGirl.create(:user)
    @user3 = FactoryGirl.create(:user)
    @position1 = FactoryGirl.create(:position, :name => 'pname1', :source => 'http://bla1', :user => @user)
    @position2 = FactoryGirl.create(:position, :name => 'pname2', :source => 'http://bla2', :user => @user)
    @position3 = FactoryGirl.create(:position, :name => 'pname3', :source => 'http://bla2', :user => @user3)
  end

  describe "GET /users/:user_id/positions.json" do
    it "gets all positions for a user when there's one position" do
      position = Factory(:position, :name => 'pname', :source => 'http://bla')
      get "/users/#{position.user_id}/positions.json"

      res = ActiveSupport::JSON.decode(response.body)
      res.first['name'].should == position.name
      res.first['source'].should == position.source
      res.first['user_id'].should == position.user.id
      res.size.should == 1
      response.status.should == 200
    end

    it "gets all positions for a user when there are two positions" do

      @position1.user.id.should == @position2.user.id
      get "/users/#{@user.id}/positions.json"

      res = ActiveSupport::JSON.decode(response.body).sort{|a,b| b['created_at'] <=> a['created_at']}
      res[1]['name'].should == @position1.name
      res[1]['source'].should == @position1.source
      res[1]['user_id'].should == @position1.user.id
      res[0]['name'].should == @position2.name
      res[0]['source'].should == @position2.source
      res[0]['user_id'].should == @position2.user.id
      res.size.should == 2
      response.status.should == 200
    end

    it "gets no positions for a user when there are no positions" do
      user = Factory(:user)
      get "/users/#{user.id}/positions.json"

      res = ActiveSupport::JSON.decode(response.body).sort{|a,b| a.to_s <=> b.to_s}
      res.should be_empty
      response.status.should == 200
    end

    it "gets no positions for a user when the user doesn't exist" do
      get "/users/88888/positions.json"

      res = ActiveSupport::JSON.decode(response.body)
      response.status.should == 404
    end
  end

  describe "POST /users/:user_id/positions.json" do
    # TODO test that we get the minimal set of required fields
    it "creates a position" do
      post "/users/#{@user.id}/positions.json", :position => {:name => 'position_name'}

      res = ActiveSupport::JSON.decode(response.body)
      res['name'].should == 'position_name'
      res['user_id'].should == @user.id
      response.status.should == 201
    end

    it "does not create a position when a name is not specified" do
      post "/users/#{@user.id}/positions.json"

      res = ActiveSupport::JSON.decode(response.body)
      response.status.should == 422
    end

    it "does not create a position when the user doesn't exist" do
      post "/users/88888/positions.json", :position => {:name => 'position_name'}

      response.status.should == 404
    end
  end

  describe "GET /users/:user_id/positions/:position_id.json" do
    it "gets a position for a user" do
      get "/users/#{@user.id}/positions/#{@position1.id}.json"

      res = ActiveSupport::JSON.decode(response.body)
      res['name'].should == 'pname1'
      res['user_id'].should == @user.id
      response.status.should == 200
    end

    it "doesn't get a position for a non-existing position" do
      Position.exists?(888888).should be_false
      get "/users/#{@user.id}/positions/888888.json"

      response.status.should == 404
    end

    it "doesn't get a position for a position belonging to a different user" do
      Position.exists?(@position3).should be_true
      get "/users/#{@position3.id}/positions/#{@position3.id}.json"

      response.status.should == 404
    end

    it "gets a position with a related email", :rel=>true do
      related_email = FactoryGirl.create(:related_email, :guid => '11s')
      get "/users/#{related_email.position.user.id}/positions/#{related_email.position.id}.json"

      res = ActiveSupport::JSON.decode(response.body)
      res['related_emails'].size.should == 1
      res['related_emails'].first['guid'].should == '11s'

      response.status.should == 200
    end
  end

  describe "DELETE /users/:user_id/positions/:position_id.json" do
    it "deletes a position" do
      Position.exists?(@position1.id).should be_true
      delete "/users/#{@user.id}/positions/#{@position1.id}.json"
      Position.exists?(@position1.id).should be_false

      response.body.should be_empty
      response.status.should == 204
    end

    it "should not care if instructed to delete a position for a non-existing position" do
      id = 88888
      Position.exists?(id).should be_false
      delete "/users/#{@user.id}/positions/#{id}.json"
      response.status.should == 204
    end

    it "should not care if instructed to delete a position for a non-existing user" do
      id = 88888
      Position.exists?(id).should be_false
      User.exists?(id).should be_false
      delete "/users/id/positions/#{id}.json"
      response.status.should == 204
    end
  end

  describe "PUT /users/:user_id/positions/:position_id.json" do
    it "updates a position when given :position => {:name => 'new_name'}" do
      put "/users/#{@user.id}/positions/#{@position1.id}.json", :position => {:name => 'new_name'}

      'pname1'.should == @position1.name
      @position1.reload
      @position1.name.should == 'new_name'
      response.status.should == 204
    end

    it "updates a position's status when given ':position => {:status => 'applied'}'" do
      put "/users/#{@user.id}/positions/#{@position1.id}.json", :position => {:pstatus => 'applied'}

      'to_apply'.should == @position1.pstatus
      @position1.reload
      @position1.pstatus.should == 'applied'
      response.status.should == 204
    end
  end

  describe "POST /users/:user_id/positions/:position_id/related_emails" do
    # TODO test that we get the minimal set of required fields
    it "creates a related_email" do
      post "/users/#{@position1.user.id}/positions/#{@position1.id}/related_emails.json", :related_email => {:guid => '1234er'}

      res = ActiveSupport::JSON.decode(response.body)
      res['guid'].should == '1234er'
      res['position_id'].should == @position1.id
      response.status.should == 201
    end

    it "does not create a position when a name is not specified" do
      post "/users/#{@user.id}/positions.json"

      res = ActiveSupport::JSON.decode(response.body)
      response.status.should == 422
    end

    it "does not create a position when the user doesn't exist" do
      post "/users/88888/positions.json", :position => {:name => 'position_name'}

      response.status.should == 404
    end
  end

  describe "POST /users/:user_id/positions/:position_id/related_emails" do
    # TODO test that we get the minimal set of required fields
    it "creates a related_email" do
      post "/users/#{@position1.user.id}/positions/#{@position1.id}/related_emails.json", :related_email => {:guid => '1234er'}

      res = ActiveSupport::JSON.decode(response.body)
      res['guid'].should == '1234er'
      res['position_id'].should == @position1.id
      response.status.should == 201
    end

    it "does not create a related email when a guid is not specified" do
      post "/users/#{@position1.user.id}/positions/#{@position1.id}/related_emails.json"

      res = ActiveSupport::JSON.decode(response.body)
      response.status.should == 422
    end

    it "does not create a relaed email when the user doesn't exist" do
      post "/users/88888/positions.json", :position => {:name => 'position_name'}

      response.status.should == 404
    end
  end

end
