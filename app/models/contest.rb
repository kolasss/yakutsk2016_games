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
#  in_group      :boolean          default(FALSE)
#  group_id      :integer
#

class Contest < ActiveRecord::Base
  include JsonValidation

  has_closure_tree dependent: :destroy,
                   order: 'sort_order'

  belongs_to :discipline

  has_many :participations,
    dependent: :destroy,
    inverse_of: :contest

  accepts_nested_attributes_for :participations, allow_destroy: true

  validates :discipline, presence: true
  validates :name,
            allow_blank: true,
            json: JSON_VALIDATION
  validates :in_group, inclusion: { in: [true, false] }

  validate :parent_discipline_equals

  scope :published, -> { where.not(published_at: nil).order(published_at: :desc) }

  def published?
    self.published_at.present?
  end

  private

    def parent_discipline_equals
      if self.parent && self.discipline &&
         self.parent.discipline != self.discipline
        errors.add(:parent_id, "дисциплина не соотвествует")
      end
    end
end
