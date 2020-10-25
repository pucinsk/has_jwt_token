# frozen_string_literal: true

module Authenticatable
  def authenticate(password)
    super(password).tap do |authenticated|
      @token = authenticated && encode || nil
    end
  end

  def authenticate_with_jwt(jwt_token)
    authenticated = decode!(jwt_token)

    if authenticated
      @token = encode
      self
    else
      @token = nil
    end
  rescue JWT::DecodeError
    nil
  end
end
