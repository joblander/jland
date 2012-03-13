require_relative '../../app/services/simply_hired_search'
require 'vcr'
require 'vcr_helper'

describe SimplyHiredSearch do
  it "returns empty search results for a garbage term" do
    VCR.use_cassette('junk_search') do
      SimplyHiredSearch.search('fasdfasdfad').should be_empty
    end
  end
  it "returns many results for a general term such as 'java'" do
    VCR.use_cassette('java') do
      SimplyHiredSearch.search('java').should_not be_empty
    end
  end
  it "returns some results for a term and a location"
end

# conn = Faraday::Connection.new(:url => 'http://localhost:7777') do |builder|
#   builder.use VCR::Middleware::Faraday do |cassette|
#     cassette.name    'faraday_example'
#     cassette.options :record => :new_episodes
#   end
#
#   builder.adapter :<adapter>
# end
#
# puts "Response 1: #{conn.get('/foo').body}"
# puts "Response 2: #{conn.get('/foo').body}"