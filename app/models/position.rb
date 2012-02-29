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

  PSTATES = [:to_review, :to_apply, :applied, :to_scedule, :interviewed]

  belongs_to :user
  belongs_to :lead_search

  validates :pstatus, :presence => true, :inclusion => { :in => PSTATES.map(&:to_s), :message => "%{value} is not a valid position status" }
  validates :name, :presence => true

  def to_s
    "name: #{name}, status: #{pstatus}"
  end

  # we'll represent state as a state machine
end
