# frozen_string_literal: true

module HasSecurePassword
  def has_secure_password # rubocop:disable Naming/PredicateName
    puts 'nice'
  end
end

module Authenticate
  def authenticate(password_test)
    password == password_test
  end
end

class BaseClass
  extend HasSecurePassword
  include Authenticate

  class << self
    def find_by(args)
      new.tap do |model|
        args.each do |key, val|
          model.send("#{key}=", val)
        end
      end
    end
  end
end

class DummyUser < BaseClass
  include HasJwtToken::Model

  attr_accessor :name, :password

  has_jwt_token do |c|
    c.identificator :name

    c.jwt_config do |jwt|
      jwt.algorithm :HS256
      jwt.payload_attribute :name
    end
  end

  # spec support
  def ==(other)
    name == other.name
  end
end
