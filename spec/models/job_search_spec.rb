require 'spec_helper'
require 'vcr'
require 'vcr_helper'

describe JobSearch do
  it "should be able to return many jobs" do
    VCR.use_cassette('ruby_job_search', :record => :new_episodes) do
      search = FactoryGirl.create(:job_search, :search_term => 'ruby', :zipcode => '15217')
      positions = search.fetch
      positions.should_not be_empty
    end
  end
end
