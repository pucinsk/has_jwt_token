# frozen_string_literal: true

require 'factory_bot'
require 'fixtures/dummy_user'

FactoryBot.define do
  factory :user, class: 'DummyUser' do
    name { 'John' }
    password { 'password' }

    trait :with_token do
      after(:build) do |user, _|
        user.instance_variable_set(:@token, SecureRandom.hex)
      end
    end

    after(:build) do |user, _|
      user.password_digest = BCrypt::Password.create(user.password)
    end
  end
end
