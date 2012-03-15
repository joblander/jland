require_relative '../../app/services/simply_hired_search'
require 'vcr'
require 'vcr_helper'

describe SimplyHiredSearch do
  it "returns empty search results for a garbage term" do
    VCR.use_cassette('junk_search', :record => :new_episodes) do
      SimplyHiredSearch.search('fasdfasdfad').should be_empty
    end
  end

  it "returns many results for a general term such as 'java'" do
    VCR.use_cassette('java', :record => :new_episodes) do
      SimplyHiredSearch.search('java').should_not be_empty
    end
  end

  it "returns many results for a general term with spaces " do
    VCR.use_cassette('ruby on rails', :record => :new_episodes) do
      SimplyHiredSearch.search('ruby on rails').should_not be_empty
    end
  end

  it "returns many results for an empty search term with a location " do
    VCR.use_cassette('empty-search-term', :record => :new_episodes) do
      SimplyHiredSearch.search('', :zipcode => '15217').should_not be_empty
    end
  end

  it "fetches all interesting fields for positions" do
    VCR.use_cassette('ruby', :record => :new_episodes) do
      pos = SimplyHiredSearch.search('ruby').first
      pos.title.should == 'Ruby Developer Job'
      pos.url.should == 'http://api.simplyhired.com/a/job-details/view/cparm-cF9pZD00MTEwNiZ6b25lPTYmaXA9JmNvdW50PTUwJnN0YW1wPTIwMTItMDMtMTMgMTA6MDk6MzkmcHVibGlzaGVyX2NoYW5uZWxfaWRzPSZhX2lkPTM1NDkyJmNfaWQ9MTQxMjcmY3BjPTAuNjYmcG9zPTEmaGFzaD1lZmYzNGQzMGZjOTkwMmRlY2QyNGMzMmVjNmY4N2U4OA%3D%3D%3B2d3754b14c4205e786e2dff0d51d0cc5/jobkey-15366.1762587A0/pub_id-41106/cjp-0'
      pos.source = "Rackspace"
      pos.city = "Austin"
      pos.state = "TX"
      pos.country = "US"
      pos.description.should include('Job Details Ruby Developer - 12925')
      pos.post_date.should == "2012-03-06T05:46:45Z"
      pos.job_type.should == "sponsored"
    end
  end

  it "searches for a term and a location" do
    VCR.use_cassette('ruby-pittsburgh', :record => :new_episodes) do
      positions = SimplyHiredSearch.search('ruby', :zipcode => '15217')
      positions.should_not be_empty
      positions.each do |pos|
        pos.state.should == 'PA'
        pos.country.should == "US"
      end
    end
  end
end