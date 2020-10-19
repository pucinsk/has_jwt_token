# frozen_string_literal: true

module HasJwtToken
  module HasJwtModelConfiguration
    def has_jwt_token
      @jwt_token_config ||= AuthorizableModelConfiguration.new
      yield(@jwt_token_config) if block_given?
      @jwt_token_config
    end
  end
end
