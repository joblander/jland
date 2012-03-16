class JobSearch < ActiveRecord::Base
  #TODO: index this field
  belongs_to :user

  def fetch
    SimplyHiredSearch.search(self.search_term, :zipcode => (self.zipcode.nil? ? nil : self.zipcode.to_s))
  end

end
# == Schema Information
#
# Table name: job_searches
#
#  id          :integer         not null, primary key
#  user_id     :integer         not null
#  search_term :string(255)
#  zipcode     :integer
#  created_at  :datetime        not null
#  updated_at  :datetime        not null
#

