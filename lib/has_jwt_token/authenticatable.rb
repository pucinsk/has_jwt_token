# frozen_string_literal: true

require 'has_jwt_token/jwt_proxy'

module HasJwtToken
  module Authenticatable
    module ClassMethods
      def find_with_jwt(jwt_token)
        payload = decode!(jwt_token)
        find_by(authenticate_by => payload[authenticate_by])
          &.tap { |model| model.token = model.encode }
      rescue JWT::DecodeError
        raise HasJwtToken::InvalidToken, 'Invalid token has been provided.'
      end

      private

      def authenticate_by
        @authenticate_by ||= begin
          auth_by_attr = has_jwt_token.authenticate_by.to_s
          return auth_by_attr if column_names.include?(auth_by_attr)

          raise HasJwtToken::BadConfiguration, "#{auth_by_attr.inspect} must be one of model attributes."
        end
      end

      def decode!(token)
        HasJwtToken::JwtProxy.decode!(
          token: token,
          algorithm: has_jwt_token.algorithm,
          secret: has_jwt_token.secret
        )
      end
    end

    def self.included(base)
      base.extend(ClassMethods)
    end

    def authenticate(password)
      super(password).tap do |authenticated|
        @token = authenticated && encode || nil
      end
    end

    def encode
      HasJwtToken::JwtProxy.encode(
        algorithm: algorithm,
        payload: model_payload.merge(claims_payload),
        secret: secret,
        header_fields: header_fields
      )
    end

    private

    delegate :algorithm, :secret, :model_payload, :claims_payload, :header_fields, to: :has_jwt_token

    def has_jwt_token
      @has_jwt_token ||= self.class.has_jwt_token(self)
    end
  end
end
