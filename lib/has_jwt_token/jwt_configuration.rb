# frozen_string_literal: true

module HasJwtToken
  class JwtConfiguration
    CLAIMS = {
      expiration_time: :exp,
      not_before_time: :nbf,
      issuer: :iss,
      audience: :aud,
      jwt_id: :jti,
      issued_at: :iat,
      subject: :sub
    }.freeze

    attr_accessor :defined_claims
    attr_reader :model
    attr_writer :payload_attribute

    def initialize(model)
      @model = model
      @payload_attribute = []
      @defined_claims = []
    end

    def algorithm(value = nil)
      return @algorithm unless value

      @algorithm = value
    end

    def payload_attribute(value = nil)
      return @payload_attribute unless value

      payload_attribute << value
    end

    CLAIMS.each do |claim_name, _|
      define_method(claim_name) do |value = nil|
        if value
          defined_claims << claim_name unless defined_claims.include?(claim_name)
          instance_variable_set("@#{claim_name}".to_sym, value)
          return value
        end

        claim_value = instance_variable_get("@#{claim_name}".to_sym)
        claim_value.is_a?(Proc) ? claim_value.call : claim_value
      end
    end

    def secret(value = nil)
      return @secret unless value

      @secret = value
    end
  end
end
