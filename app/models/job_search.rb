class JobSearch < ActiveRecord::Base
  belongs_to :user

  def fetch
    SimplyHiredSearch.search(self.search_term, :zipcode => self.zipcode.to_s)
  end
end
