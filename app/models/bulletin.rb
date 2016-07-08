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

  mount_uploader :file, FileUploader

  validates :title,
            presence: true,
            json: JSON_VALIDATION
  validates :file, presence: true
  validates :date, presence: true

  before_save :store_metadata

  scope :by_date, -> { order(date: :desc) }

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
