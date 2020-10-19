# frozen_string_literal: true

require 'has_jwt_token/jwt_configuration'

module HasJwtToken
  class AuthorizableModelConfiguration
    def identificator=(value)
      @identificator = value.to_sym
    end

    def identificator(value = nil)
      return @identificator unless value

      @identificator = value.to_sym
    end

    def jwt
      @jwt ||= JwtConfiguration.new
      yield(@jwt) if block_given?
      @jwt
    end
  end
end
