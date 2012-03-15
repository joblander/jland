class JobSearch < ActiveRecord::Base
  #TODO: index this field
  belongs_to :user

  def fetch
    SimplyHiredSearch.search(self.search_term, :zipcode => (self.zipcode.nil? ? nil : self.zipcode.to_s))
  end

end
