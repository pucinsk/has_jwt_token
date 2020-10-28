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

    attr_accessor :model
    attr_reader :defined_claims

    def initialize
      @payload = {}
      @defined_claims = []
    end

    def algorithm(value = nil)
      return @algorithm unless value

      @algorithm = value
    end

    def secret(value = nil)
      return @secret unless value

      @secret = value
    end

    CLAIMS.each_key do |claim_name|
      define_method(claim_name) do |value = nil|
        unless value
          claim_value = instance_variable_get("@#{claim_name}".to_sym)
          return claim_value.is_a?(Proc) ? claim_value.call : claim_value
        end

        @defined_claims |= [claim_name]
        instance_variable_set("@#{claim_name}".to_sym, value)
      end
    end

    def model_payload
      @payload.transform_values do |val|
        next val if !val.is_a?(Proc) || !model

        begin
          val.call(model)
        rescue ArgumentError
          val.call
        end
      end
    end

    def payload(name = nil, value = nil)
      @payload[name] = value || ->(model) { model.respond_to?(name) && model.public_send(name) } if name
    end

    def claims_payload
      defined_claims.each_with_object({}) do |claim_name, memo|
        claim_key = CLAIMS[claim_name]
        memo[claim_key] = public_send(claim_name)
      end
    end
  end
end
