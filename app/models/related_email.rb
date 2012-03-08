class RelatedEmail < ActiveRecord::Base
  belongs_to :position
end
# == Schema Information
#
# Table name: related_emails
#
#  id          :integer         not null, primary key
#  guid        :string(255)     not null
#  position_id :integer         not null
#  created_at  :datetime        not null
#  updated_at  :datetime        not null
#

