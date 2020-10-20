# frozen_string_literal: true

require 'jwt'

module HasJwtToken
  class JwtProxy
    attr_reader :algorithm, :payload, :secret

    def initialize(algorithm: nil, payload: nil, secret: nil)
      @algorithm = algorithm
      @payload = payload
      @secret = secret
    end

    def encode
      JWT.encode(payload, secret, algorithm)
    end

    def decode(token)
      JWT.decode(token, secret, false, algorithm: algorithm)[0]
    end

    def decode!(token)
      JWT.decode(token, secret, true, algorithm: algorithm)[0]
    end

    private

    def valid?
      decode! && true
    rescue JWT::DecodeError
      false
    end
  end
end
