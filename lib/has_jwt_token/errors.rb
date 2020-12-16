# frozen_string_literal: true

module HasJwtToken
  HasJwtTokenError = Class.new(StandardError)

  class InvalidToken < HasJwtTokenError; end
  class BadConfiguration < HasJwtTokenError; end
end
