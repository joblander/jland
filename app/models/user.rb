class User < ActiveRecord::Base
  has_many :positions
  has_secure_password
  validates_presence_of :password, :on => :create
  validates_uniqueness_of :email
end
