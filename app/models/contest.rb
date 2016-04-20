# == Schema Information
#
# Table name: contests
#
#  id            :integer          not null, primary key
#  name          :string
#  start_at      :datetime
#  published_at  :datetime
#  parent_id     :integer
#  sort_order    :integer
#  location_id   :integer          not null
#  discipline_id :integer          not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class Contest < ActiveRecord::Base
  has_closure_tree dependent: :destroy,
                   order: 'sort_order'

  belongs_to :location
  belongs_to :discipline

  has_many :participations, dependent: :destroy

  validates :location, presence: true
  validates :discipline, presence: true
end
