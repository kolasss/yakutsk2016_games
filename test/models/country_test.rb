# == Schema Information
#
# Table name: countries
#
#  id           :integer          not null, primary key
#  name         :jsonb            not null
#  flag         :string
#  info         :jsonb
#  gold_count   :integer          default(0), not null
#  silver_count :integer          default(0), not null
#  bronze_count :integer          default(0), not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

require 'test_helper'

class CountryTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
