# frozen_string_literal: true

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
  include HasJwtToken

  attr_accessor :name, :password_digest

  has_jwt_token do |c|
    c.identificator :name

    c.jwt do |jwt|
      jwt.algorithm 'HS256'
      jwt.payload_attribute :name
      jwt.secret 'secret'
    end
  end

  # spec support

  def ==(other)
    name == other.name
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
