# frozen_string_literal: true

require 'jwt'

module HasJwtToken
  class JwtProxy
    class << self
      def encode(payload:, secret: '', algorithm: '', header_fields: {})
        JWT.encode(payload, secret, algorithm, header_fields)
      end

      def decode!(token:, secret: '', algorithm: '')
        JWT.decode(token, secret, true, algorithm: algorithm)[0]
      end
    end
  end
end
