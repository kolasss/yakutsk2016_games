# == Schema Information
#
# Table name: contests
#
#  id            :integer          not null, primary key
#  name          :jsonb
#  start_at      :datetime
#  published_at  :datetime
#  parent_id     :integer
#  sort_order    :integer
#  discipline_id :integer          not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class Contest < ActiveRecord::Base
  include JsonValidation

  has_closure_tree dependent: :destroy,
                   order: 'sort_order'

  belongs_to :discipline

  has_many :participations, dependent: :destroy

  accepts_nested_attributes_for :participations, allow_destroy: true

  validates :discipline, presence: true
  validates :name,
            allow_blank: true,
            json: JSON_VALIDATION

  scope :published, -> { where.not(published_at: nil).order(published_at: :desc) }

  def published?
    self.published_at.present?
  end
end
