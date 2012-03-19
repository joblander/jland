# == Schema Information
#
# Table name: users
#
#  id              :integer         not null, primary key
#  email           :string(255)     not null
#  password_digest :string(255)
#  first_name      :string(255)
#  last_name       :string(255)
#  created_at      :datetime        not null
#  updated_at      :datetime        not null
#

require 'spec_helper'

describe User do

  it "creates a new job search for new users" do
    user = User.create!(:email => 'joe@example.com', :password => 'pass', :password_digest => 'dafdsfas')
    user.job_search.should_not be_nil
    user.job_search.user.should == user
  end

  describe 'fetching positions' do
  	before do
	  	@user = FactoryGirl.create(:user)
	  	@user.job_search.update_attributes(:search_term => 'java')
	  	@position1 = FactoryGirl.create(:position, :name => 'p1', :pstatus => 'to_apply', :user => @user)
  	end
  	it "fetches to_review positions"  do
  	  VCR.use_cassette('to_review_positions_model', :record => :new_episodes) do	
	  	  positions = @user.fetch_positions('to_review')
	      positions.size.should == 10
	      positions.each { |p|  p.pstatus.should == 'to_review'}
  	  end
		end
  	it "fetches to_apply positions" do
      positions = @user.fetch_positions('to_apply')
      positions.size.should == 1
      positions.first.name.should == @position1.name
  	end
  end
end
