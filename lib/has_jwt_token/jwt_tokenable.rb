# frozen_string_literal: true

require 'has_jwt_token/jwt_proxy'

module HasJwtToken
  module JwtTokenable
    delegate :algorithm, :secret, :claims_payload, :header_fields, to: :has_jwt_token

    def encode
      with_jwt_configuration(&:encode)
    end

    def decode(token)
      with_jwt_configuration { |jwt| jwt.decode(token) }
    end

    def decode!(token)
      with_jwt_configuration { |jwt| jwt.decode!(token) }
    end

    def has_jwt_token
      self.class.has_jwt_token(self)
    end

    private

    def payload
      @payload ||= has_jwt_token.model_payload.merge(claims_payload)
    end

    def with_jwt_configuration
      yield(jwt_proxy)
    end

    def jwt_proxy
      @jwt_proxy ||= JwtProxy.new(
        algorithm: algorithm,
        payload: payload,
        secret: secret,
        header_fields: header_fields
      )
    end
  end
end
