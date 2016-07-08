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

require 'test_helper'

class AttachmentTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
