# == Schema Information
#
# Table name: positions
#
#  id             :integer         not null, primary key
#  user_id        :integer         not null
#  lead_search_id :integer
#  source         :string(255)
#  name           :string(255)
#  details        :text
#  created_at     :datetime        not null
#  updated_at     :datetime        not null
#

class Position < ActiveRecord::Base
  belongs_to :user
  belongs_to :lead_search

  validates :name, :presence => true

  # we'll represent state as a state machine
end
