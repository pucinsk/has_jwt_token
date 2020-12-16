# frozen_string_literal: true

require 'has_jwt_token/jwt_configuration'

module HasJwtToken
  module HasJwtModelConfiguration
    def has_jwt_token(model = nil)
      @has_jwt_token ||= JwtConfiguration.new
      yield(@has_jwt_token) if block_given?
      @has_jwt_token.tap { |jwt| jwt.model = model if model }
    end
  end
end
