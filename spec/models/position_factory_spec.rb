require 'spec_helper'
require 'ostruct'

describe PositionFactory do
  it "creates a position from search results" do
    search_results = FactoryGirl.create(:simply_hired_search_results)

    position = PositionFactory.build_from_search_results(search_results)
    position.valid?.should be_true
  end

  it "creates a postion with all fields filled out" do

    search_results = FactoryGirl.create(:simply_hired_search_results, :title => 'title',
      :url => 'http://jobsite.com',
      :description => 'job description',
      :post_date => '12/12/2011',
      :source => 'some company',
      :city => 'pittsburgh',
      :state => 'pa',
      :country => 'US')

    position = PositionFactory.build_from_search_results(search_results)

    position.valid?.should be_true
    position.name.should == 'title'
    position.app_link.should == 'http://jobsite.com'
    position.source.should == 'some company'
    position.company.should == 'some company'
    position.city.should == 'pittsburgh'
    position.state.should == 'pa'
    position.country.should == 'US'
    position.details.should == 'job description'
    position.post_date.should == Time.parse('12/12/2011')
    position.pstatus.should == 'to_review'
  end

  it "does not create a position from search results of non optional fields are missing" do
    search_results = FactoryGirl.create(:simply_hired_search_results, :title => nil)

    position = PositionFactory.build_from_search_results(search_results)
    position.valid?.should be_false
  end
end
