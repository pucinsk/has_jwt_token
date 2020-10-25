# frozen_string_literal: true

require 'active_model'
require 'bcrypt'
require 'has_jwt_token/authenticatable'
require 'has_jwt_token/has_jwt_model_configuration'
require 'has_jwt_token/jwt_tokenable'

module HasJwtToken
  module Model
    attr_reader :token

    def self.included(base)
      base.include(ActiveModel::SecurePassword)
      base.has_secure_password
      base.include(Authenticatable)
      base.extend(HasJwtModelConfiguration)
      base.include(JwtTokenable)
    end
  end
end
