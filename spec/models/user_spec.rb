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
	  	@user.job_search.update_attributes(:search_term => 'java', :zipcode => 15217)
	  	@position1 = FactoryGirl.create(:position, :name => 'p1', :pstatus => 'to_apply', :user => @user)
  	end
  	
  	it "fetches to_review positions"  do
  		positions = [
        OpenStruct.new({ title: 'Post #1', pstatus: 'to_review' }),
        OpenStruct.new({ title: 'Post #2', pstatus: 'to_review' }),
        OpenStruct.new({ title: 'Post #3', pstatus: 'to_review' })
      ]
      SimplyHiredSearch.should_receive(:search).with('java',{:zipcode => '15217'})
      	.and_return(positions)
	  	
  	  positions = @user.fetch_positions('to_review')
      positions.size.should == 3
      positions.each { |p|  p.pstatus.should == 'to_review'}
		end
  	it "fetches to_apply positions" do
      positions = @user.fetch_positions('to_apply')
      positions.size.should == 1
      positions.first.name.should == @position1.name
  	end
  end
end
