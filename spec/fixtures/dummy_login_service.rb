require 'active_model'
require_relative 'dummy_user'

class DummyLoginService
  include ActiveModel::Validations

  attr_accessor :name, :password

  validate :require_user_to_exist

  def initialize(name, password)
  end

  def call
    return false unless valid?

    if user.authenticate(password)
      @token = user.token
    else
      errors.add('user', 'credentials are not valid')
      false
    end
  end

  private

  def user
    @user ||= DummyUser.find_by(name: name, password: password)
  end

  def require_user_to_exist
    return if user

    errors.add('user', 'is not found')
  end
end
