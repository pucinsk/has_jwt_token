# frozen_string_literal: true

module HasJwtToken
  class JwtConfiguration
    attr_reader :model

    def initialize(model)
      @model = model
      @payload_attribute = []
    end

    def algorithm(value = nil)
      return @algorithm unless value

      @algorithm = value
    end

    def payload_attribute(value = nil)
      return @payload_attribute unless value

      @payload_attribute << value
    end

    def secret(value = nil)
      return @secret unless value

      @secret = value
    end

    def payload
      @payload ||= payload_attribute.each_with_object({}) do |attribute, memo|
        memo.merge(attribute => model.public_send(attribute))
      end
    end
  end
end
