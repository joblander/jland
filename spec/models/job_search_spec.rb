require 'spec_helper'

describe JobSearch do

  describe 'fetching positions' do
  	before do
	  	@job_search = FactoryGirl.create(:job_search, :search_term => 'java', :zipcode => 15217)
	  	@position1 = FactoryGirl.create(:position, :name => 'p1', 
        :pstatus => 'to_apply', :user => @job_search.user)
  	end
  	
  	it "fetches to_review positions"  do
  		positions = [
        OpenStruct.new({ title: 'Post #1', pstatus: 'to_review' }),
        OpenStruct.new({ title: 'Post #2', pstatus: 'to_review' }),
        OpenStruct.new({ title: 'Post #3', pstatus: 'to_review' })
      ]
      SimplyHiredSearch.should_receive(:search).with('java',{:zipcode => '15217'})
      	.and_return(positions)
	  	
  	  positions = @job_search.fetch
      positions.size.should == 3
      positions.each { |p|  p.pstatus.should == 'to_review'}
		end
  end
end
