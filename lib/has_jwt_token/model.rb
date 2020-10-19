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
      base.include(JwtTokenable)
    end

    def jwt_token_config
      @jwt_token_config ||= self.class.jwt_token_config
    end

    def jwt_config
      @jwt_config ||= jwt_token_config.jwt_config
    end
  end
end
