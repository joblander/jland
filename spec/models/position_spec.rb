# == Schema Information
#
# Table name: positions
#
#  id             :integer         not null, primary key
#  user_id        :integer         not null
#  lead_search_id :integer
#  source         :string(255)
#  name           :string(255)     not null
#  details        :text
#  created_at     :datetime        not null
#  updated_at     :datetime        not null
#  pstatus        :string(255)     default("to_apply"), not null
#

require 'spec_helper'

describe Position do
end
