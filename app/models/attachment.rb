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
#

class Attachment < ActiveRecord::Base
  include JsonValidation

  belongs_to :sport, inverse_of: :attachments

  mount_uploader :file, FileUploader

  validates :title,
            presence: true,
            json: JSON_VALIDATION
  validates :sport, presence: true
  validates :file, presence: true

  before_save :store_metadata

  scope :by_created, -> { order(created_at: :desc) }

  private

    def store_metadata
      if file.present? && file_changed?
        self.meta = {
          size: file.file.size,
          content_type: file.file.content_type,
          extension: file.file.extension.downcase
        }
      end
    end
end
