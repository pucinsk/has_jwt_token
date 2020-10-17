# frozen_string_literal: true

require 'active_support'

require 'has_jwt_token/authorizable_model_configuration'
require 'has_jwt_token/authenticate_by_identificator'
require 'has_jwt_token/has_jwt_model_configuration'

module HasJwtToken
  module Model
    extend ActiveSupport::Concern

    included do
      has_secure_password
      extend(HasJwtModelConfiguration)
      extend(AuthenticateByIdentificator)
    end
  end
end
