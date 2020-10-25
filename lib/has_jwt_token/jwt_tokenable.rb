# frozen_string_literal: true

require 'has_jwt_token/jwt_proxy'

module HasJwtToken
  module JwtTokenable
    delegate :algorithm, :secret, :payload_attribute,
             :defined_claims, to: :has_jwt_token

    def encode
      with_jwt_configuration(&:encode)
    end

    def decode(token)
      with_jwt_configuration { |jwt| jwt.decode(token) }
    end

    def decode!(token)
      with_jwt_configuration { |jwt| jwt.decode!(token) }
    end

    private

    def has_jwt_token
      self.class.has_jwt_token
    end

    def payload
      @payload ||= model_payload.merge(claims_payload)
    end

    def model_payload
      payload_attribute.each_with_object({}) do |attribute, memo|
        memo[attribute] = public_send(attribute)
      end
    end

    def claims_payload
      defined_claims.each_with_object({}) do |claim_name, memo|
        claim_key = HasJwtToken::JwtConfiguration::CLAIMS[claim_name]
        memo[claim_key] = has_jwt_token.public_send(claim_name)
      end
    end

    def with_jwt_configuration
      yield(jwt_proxy)
    end

    def jwt_proxy
      @jwt_proxy ||= JwtProxy.new(
        algorithm: algorithm,
        payload: payload,
        secret: secret
      )
    end
  end
end
