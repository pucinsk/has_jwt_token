# frozen_string_literal: true

require 'has_jwt_token/authorizable_model_configuration'

module HasJwtToken
  module HasJwtModelConfiguration
    def has_jwt_token
      @jwt_token_config ||= AuthorizableModelConfiguration.new(self)
      yield(@jwt_token_config) if block_given?
      @jwt_token_config
    end
  end
end
