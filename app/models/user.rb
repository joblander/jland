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
  extend Forwardable

  has_many :positions
  has_one :job_search
  has_secure_password
  validates_presence_of :password, :on => :create
  validates_uniqueness_of :email

  after_create :create_job_search

  attr_writer :job_search_source

  def fetch_positions(pstatus)
    if pstatus == 'to_review'
      do_job_search.collect{|search_result| PositionFactory.build_from_search_results(search_result)}
    else
      Array(self.positions.find_by_pstatus(pstatus))
    end
  end

  def do_job_search
    self.job_search.fetch
  end

  private

  def job_search_source
    @job_search_source ||= JobSearch.public_method(:new)
  end

  def create_job_search
    # change to self.job_search << job_search_source.call when we have has_many
    self.job_search = job_search_source.call.tap do |js|
      js.user = self
    end
  end
end
