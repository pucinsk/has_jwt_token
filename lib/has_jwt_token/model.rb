# frozen_string_literal: true

require 'active_model'
require 'bcrypt'
require 'has_jwt_token/has_jwt_model_configuration'
require 'has_jwt_token/jwt_tokenable'

module HasJwtToken
  module Authenticate
    def authenticate(password)
      super(password).tap do |authenticated|
        @token = authenticated && encode || nil
      end
    end
  end

  module Model
    attr_reader :token

    def self.included(base)
      base.include(ActiveModel::SecurePassword)
      base.has_secure_password
      base.include(Authenticate)
      base.extend(HasJwtModelConfiguration)
      base.include(JwtTokenable)
    end

    def has_jwt_token
      @has_jwt_token ||= self.class.has_jwt_token
    end
  end
end
