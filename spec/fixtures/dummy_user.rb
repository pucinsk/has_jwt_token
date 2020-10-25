# frozen_string_literal: true

require 'has_jwt_token/model'

class BaseClass
  class << self
    def find_by(args)
      new.tap do |model|
        default_args.merge(args).each do |key, val|
          model.send("#{key}=", val)
        end
      end
    end

    private

    def default_args
      {}
    end
  end
end

class DummyUser < BaseClass
  include HasJwtToken::Model

  attr_accessor :name, :password_digest

  has_jwt_token do |jwt|
    jwt.algorithm 'HS256'
    jwt.payload_attribute :name
    jwt.secret 'secret'

    jwt.expiration_time -> { Time.now.to_i + 60 }
    jwt.not_before_time -> { Time.now.to_i }
    jwt.issued_at -> { Time.now.to_i }
    jwt.jwt_id -> { SecureRandom.hex }
    jwt.issuer :dummy_app
    jwt.audience :client_app
    jwt.subject :dummy_app
  end

  class << self
    private

    def default_args
      {
        name: 'John',
        password: 'password',
        password_confirmation: 'password',
        password_digest: BCrypt::Password.create('password')
      }
    end
  end
end
