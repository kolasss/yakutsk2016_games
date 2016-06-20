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

require 'test_helper'

class UserTest < ActiveSupport::TestCase

  def setup
    @user = User.new(
      email: "user_test@example.com",
      password: "123",
      password_confirmation: "123"
    )
  end

  test "should be valid" do
    assert @user.valid?
  end

  test "email should be present" do
    @user.email = nil
    assert_not @user.valid?
  end

  test "email should be uniq" do
    @user.email = users(:one).email
    assert_not @user.valid?
  end

  test "password should be present" do
    @user.password = nil
    assert_not @user.valid?
  end

  test "password_confirmation should be present" do
    @user.password_confirmation = nil
    assert_not @user.valid?
  end

  test "password_confirmation should be equal password" do
    @user.password_confirmation = "qwe"
    assert_not @user.valid?
  end

  test "password's length should be greater than 2" do
    @user.password = "12"
    @user.password_confirmation = @user.password
    assert_not @user.valid?
  end

  test "password's length should be less than 101" do
    @user.password = "a" * 101
    @user.password_confirmation = @user.password
    assert_not @user.valid?
  end

  test 'password can be blank for update' do
    user = users(:one)
    user.email = "супер поставщик"
    assert_nil user.password
    assert_nil user.password_confirmation
    assert user.valid?
  end

  test 'password_confirmation should be equal to password for update' do
    user = users(:one)
    user.password = "secret"
    assert_not user.valid?
    user.password_confirmation = "secret"
    assert user.valid?
  end

  test "can have authentications" do
    user = users(:one)
    assert user.authentications.any?
  end

  test 'should destroy authentications with user' do
    user = users(:one)
    assert_difference('Authentication.count', -1) do
      user.destroy
    end
  end
end
