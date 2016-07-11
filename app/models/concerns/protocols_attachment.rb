module ProtocolsAttachment
  extend ActiveSupport::Concern

  included do
    mount_uploader :file, FileUploader

    validates :file, presence: true
    validates :date, presence: true

    before_save :store_metadata

    scope :by_date, -> { order(date: :desc) }
  end

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
