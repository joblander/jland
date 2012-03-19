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

class User < ActiveRecord::Base
  has_many :positions
  has_one :job_search
  has_secure_password
  validates_presence_of :password, :on => :create
  validates_uniqueness_of :email

  after_create :create_job_search

  def fetch_positions(pstatus)
    if pstatus == 'to_review'
      self.job_search.fetch.collect{|search_result| PositionFactory.build_from_search_results(search_result)}
    else
      Array(self.positions.find_by_pstatus(pstatus))
    end
  end

  private

  def create_job_search
    self.job_search = JobSearch.new
  end
end
