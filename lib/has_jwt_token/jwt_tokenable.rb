# frozen_string_literal: true

require 'jwt'

module HasJwtToken
  module JwtTokenable
    def token
      @token ||= JwtProxy.encode(
        payload: jwt_config.payload,
        secret: jwt_config.secret,
        algorithm: jwt_config.algorithm
      )
    end
  end
end
