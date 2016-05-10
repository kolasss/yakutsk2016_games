# == Schema Information
#
# Table name: authentications
#
#  id         :integer          not null, primary key
#  info       :jsonb
#  user_id    :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Authentication < ActiveRecord::Base
  belongs_to :user

  validates :user, presence: true
end
