# == Schema Information
#
# Table name: attachments
#
#  id         :integer          not null, primary key
#  title      :jsonb            not null
#  file       :string
#  meta       :jsonb            not null
#  sport_id   :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  date       :date             not null
#

class Attachment < ActiveRecord::Base
  include JsonValidation
  include ProtocolsAttachment

  belongs_to :sport, inverse_of: :attachments

  validates :sport, presence: true
  validates :title,
            presence: true,
            json: JSON_VALIDATION
end
