# continue by doing something similar to https://gist.github.com/845583
World(Rack::Test::Methods)

Given /^I am an API user$/ do
  @user = FactoryGirl.create(:user)
end

Given /^I have a position$/ do
  @position = FactoryGirl.create(:position, :name => 'pname1', :source => 'http://bla1', :user => @user)
end

Given /^I have 2 positions$/ do
  @position1 = FactoryGirl.create(:position, :name => 'pname1', :source => 'http://bla1', :user => @user)
  @position2 = FactoryGirl.create(:position, :name => 'pname2', :source => 'http://bla2', :user => @user)
end

Given /^I send and accept JSON$/ do
  header 'Accept', 'application/json'
  header 'Content-Type', 'application/json'
end

When /^I send a GET request for "([^\"]*)"$/ do |path|
  get path
  #puts "request: #{request.inspect}"
end

When /^I send a POST request to "([^\"]*)" with the following:$/ do |path, body|
  post path, body
end

When /^I send a PUT request to "([^\"]*)" with the following:$/ do |path, body|
  put path, body
end

When /^I send a DELETE request to "([^\"]*)"$/ do |path|
  delete path
end

Then /^the response code should be (\d+)$/ do |status|
  last_response.status.should == status.to_i
end

Then /^the JSON response should be an array with (\d+) "([^\"]*)" elements$/ do |number_of_children, name|
  page = JSON.parse(last_response.body)
  page.map { |d| d[name] }.length.should == number_of_children.to_i
end