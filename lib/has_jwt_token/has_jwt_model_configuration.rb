# frozen_string_literal: true

require 'has_jwt_token/jwt_configuration'

module HasJwtToken
  module HasJwtModelConfiguration
    def has_jwt_token
      @has_jwt_token ||= JwtConfiguration.new(self)
      yield(@has_jwt_token) if block_given?
      @has_jwt_token
    end
  end
end
