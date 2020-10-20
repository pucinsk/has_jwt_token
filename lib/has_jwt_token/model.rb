# frozen_string_literal: true

module HasJwtToken
  module Model
    attr_accessor :token

    delegate :jwt, to: :jwt_token_config

    def authenticate(password)
      super(password)
      @token = encode
    end

    def jwt_token_config
      @jwt_token_config ||= self.class.has_jwt_token
    end
  end
end
