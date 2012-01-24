class Position < ActiveRecord::Base
  belongs_to :user
  belongs_to :lead_search

  # we'll represent state as a state machine
end
