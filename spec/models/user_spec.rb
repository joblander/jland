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
end
