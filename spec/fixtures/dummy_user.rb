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

    def self.column_names
      {}
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
    jwt.payload :name, auth_by: true # model attribute #name
    jwt.payload :custom_proc_class_method, value: -> { dummy_class_method }
    jwt.payload :custom_proc_istance_method, value: ->(model) { model.dummy_instance_method }
    jwt.payload :custom_plain_value, value: 321
    jwt.secret 'secret'

    jwt.header :header_field, :header_value
    jwt.header :header_field2, -> { 123 }

    jwt.expiration_time -> { Time.now.to_i + 60 }
    jwt.not_before_time -> { Time.now.to_i }
    jwt.issued_at -> { Time.now.to_i }
    jwt.jwt_id -> { SecureRandom.hex }
    jwt.issuer :dummy_app
    jwt.audience :client_app
    jwt.subject :dummy_app
  end

  def initialize(name: 'John', password_digest: 'secret')
    super()
    @name = name
    @password_digest = password_digest
  end

  def self.column_names
    %w[name password_digest]
  end

  def self.dummy_class_method
    'dummy_class_method'
  end

  def dummy_instance_method
    'dummy_instance_method'
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
