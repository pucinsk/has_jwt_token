# frozen_string_literal: true

require 'jwt'

module HasJwtToken
  class JwtProxy
    HMACK = 'HS256'

    attr_reader :token

    class << self
      def encode(payload:, secret:, algorithm:)
        token = JWT.encode(payload, secret, algorithm)

        new(token: token, payload: payload)
      end

      def decode(token)
        jwt = new(token: token)
        jwt.valid? ? jwt : nil
      end

      def secret
        Rails.application.credentials.secret
      end
    end

    def initialize(token:, payload: nil)
      @token = token
      @payload = payload
    end

    def payload
      return @payload unless @payload.nil?

      @payload = decode.symbolize_keys
    end

    private

    def decode
      JWT.decode(token, secret, false, algorithm: HMACK)[0]
    end

    def decode!
      JWT.decode(token, secret, true, algorithm: HMACK)[0]
    end

    def secret
      self.class.secret
    end

    def valid?
      decode! && true
    rescue JWT::DecodeError
      false
    end
  end
end
