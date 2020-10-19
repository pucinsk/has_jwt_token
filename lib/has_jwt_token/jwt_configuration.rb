# frozen_string_literal: true

module HasJwtToken
  class JwtConfiguration
    def initialize
      @payload_attributes = []
    end

    def algorithm(value = nil)
      return @algorithm unless value

      @algorithm = value
    end

    def payload_attribute(value = nil)
      return @payload_attributes unless value

      @payload_attributes << value
    end

    def secret(value = nil)
      return @secret unless value

      @secret = value
    end
  end
end
