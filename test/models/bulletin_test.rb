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

require 'test_helper'

class BulletinTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
