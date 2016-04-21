# == Schema Information
#
# Table name: users
#
#  id               :integer          not null, primary key
#  email            :string           not null
#  crypted_password :string
#  salt             :string
#  created_at       :datetime
#  updated_at       :datetime
#

class User < ActiveRecord::Base
  authenticates_with_sorcery!

  PASSWORD_LENGTH = 3..100

  validates :password, presence: true,
    length: {in: PASSWORD_LENGTH },
    confirmation: true,
    on: :create

  validates :password, allow_blank: true,
    length: {in: PASSWORD_LENGTH },
    confirmation: true,
    on: :update

  validates :email, uniqueness: true, presence: true
end
