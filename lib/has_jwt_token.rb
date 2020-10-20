# frozen_string_literal: true

require 'active_support/core_ext/module/delegation'

module HasJwtToken
  require 'active_support'
  require 'active_model'
  require 'bcrypt'

  require 'has_jwt_token/version'
  require 'has_jwt_token/model'
  require 'has_jwt_token/authenticate_by_identificator'
  require 'has_jwt_token/has_jwt_model_configuration'
  require 'has_jwt_token/jwt_tokenable'

  extend ActiveSupport::Concern

  included do
    include ActiveModel::Validations
    include ActiveModel::SecurePassword
    has_secure_password
    extend HasJwtModelConfiguration
    extend AuthenticateByIdentificator
    include Model
    include JwtTokenable
  end
end
