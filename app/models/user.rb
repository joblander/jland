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
  has_many :related_emails
  has_secure_password
  validates_presence_of :password, :on => :create
  validates_uniqueness_of :email

  #attr_accessible :name, :email
end
