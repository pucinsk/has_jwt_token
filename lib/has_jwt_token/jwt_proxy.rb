# frozen_string_literal: true

require 'jwt'

module HasJwtToken
  class JwtProxy
    attr_reader :algorithm, :payload, :secret, :header_fields

    def initialize(algorithm: '', payload: {}, secret: '', header_fields: {})
      @algorithm = algorithm
      @payload = payload
      @secret = secret
      @header_fields = header_fields
    end

    def encode
      JWT.encode(payload, secret, algorithm, header_fields)
    end

    def decode(token)
      JWT.decode(token, secret, false, algorithm: algorithm)[0]
    end

    def decode!(token)
      JWT.decode(token, secret, true, algorithm: algorithm)[0]
    end

    def valid?(token)
      decode!(token) && true
    rescue JWT::DecodeError
      false
    end
  end
end
