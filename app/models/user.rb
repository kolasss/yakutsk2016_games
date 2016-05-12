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

  has_many :authentications, dependent: :destroy

  PASSWORD_LENGTH = 3..100

  validates :password,
    length: {in: PASSWORD_LENGTH },
    confirmation: true,
    if: :need_password_validation?
  validates :password_confirmation,
    presence: true,
    if: :need_password_validation?

  validates :email, uniqueness: true, presence: true

  private

    def need_password_validation?
      new_record? || changes[:crypted_password]
    end
end
