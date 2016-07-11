# == Schema Information
#
# Table name: bulletins
#
#  id         :integer          not null, primary key
#  title      :jsonb            not null
#  file       :string
#  date       :date             not null
#  meta       :jsonb            not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Bulletin < ActiveRecord::Base
  include JsonValidation
  include ProtocolsAttachment

  validates :title,
            presence: true,
            json: JSON_VALIDATION
end
