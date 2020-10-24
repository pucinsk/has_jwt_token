# frozen_string_literal: true

require 'has_jwt_token/jwt_proxy'

module HasJwtToken
  module JwtTokenable
    delegate :algorithm, :payload, :secret, :payload_attribute, to: :has_jwt_token

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

    def payload
      @payload ||= payload_attribute.each_with_object({}) do |attribute, memo|
        memo.merge(attribute => public_send(attribute))
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
