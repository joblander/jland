require 'spec_helper'
require 'ostruct'

describe PositionFactory do
  it "creates a position from search results" do
    search_results = FactoryGirl.create(:simply_hired_search_results)

    position = PositionFactory.build_from_search_results(search_results)
    position.valid?.should be_true
  end

  it "does not create a position from search results of non optional fields are missing" do
    search_results = FactoryGirl.create(:simply_hired_search_results, :title => nil)

    position = PositionFactory.build_from_search_results(search_results)
    position.valid?.should be_false
  end
end
