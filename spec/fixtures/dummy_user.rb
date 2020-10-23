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
