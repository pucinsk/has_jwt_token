# frozen_string_literal: true

require 'has_jwt_token/authorizable_model_configuration'
require 'has_jwt_token/authenticate_by_identificator'
require 'has_jwt_token/has_jwt_model_configuration'

module HasJwtToken
  module Model
    def self.included(base)
      base.has_secure_password
      base.extend(HasJwtModelConfiguration)
      base.extend(AuthenticateByIdentificator)
    end
  end
end
