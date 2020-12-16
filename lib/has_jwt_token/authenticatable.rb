# frozen_string_literal: true

module Authenticatable
  module ClassMethods
    def find_with_jwt(jwt_token)
      payload = decode!(jwt_token)
      find_by(authenticate_by => payload[authenticate_by])
        &.tap { |model| model.token = model.encode }
    rescue JWT::DecodeError
      raise HasJwtToken::InvalidToken, 'Invalid token has been provided.'
    end

    private

    def authenticate_by
      @authenticate_by ||= begin
        auth_by_attr = has_jwt_token.authenticate_by.to_s
        return auth_by_attr if column_names.include?(auth_by_attr)

        raise HasJwtToken::BadConfiguration, "#{auth_by_attr.inspect} must be one of model attributes."
      end
    end
  end

  def self.included(base)
    base.extend(ClassMethods)
  end

  def authenticate(password)
    super(password).tap do |authenticated|
      @token = authenticated && encode || nil
    end
  end
end
