# frozen_string_literal: true

require 'active_support'

require 'has_jwt_token/authorizable_model_configuration'
require 'has_jwt_token/authenticate_by_identificator'
require 'has_jwt_token/sessionable'

module HasJwtToken
  module Model
    extend ActiveSupport::Concern

    included do
      has_secure_password
      extend(Sessionable)
      extend(AuthenticateByIdentificator)
    end
  end
end
