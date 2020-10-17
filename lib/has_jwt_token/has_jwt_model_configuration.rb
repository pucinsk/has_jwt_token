# frozen_string_literal: true

module HasJwtToken
  module HasJwtModelConfiguration
    def has_jwt_token
      @session_config ||= AuthorizableModelConfiguration.new
      yield(@session_config) if block_given?
      @session_config
    end
  end
end
