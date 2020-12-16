# frozen_string_literal: true

require 'has_jwt_token/jwt_proxy'

module HasJwtToken
  module JwtTokenable
    delegate :algorithm, :secret, :model_payload, :claims_payload, :header_fields, to: :has_jwt_token

    module ClassMethods
      def decode!(token)
        JwtProxy.decode!(
          token: token,
          algorithm: has_jwt_token.algorithm,
          secret: has_jwt_token.secret
        )
      end
    end

    def self.included(base)
      base.extend(ClassMethods)
    end

    def encode
      JwtProxy.encode(
        algorithm: algorithm,
        payload: model_payload.merge(claims_payload),
        secret: secret,
        header_fields: header_fields
      )
    end

    private

    def has_jwt_token
      @has_jwt_token ||= self.class.has_jwt_token(self)
    end
  end
end
