# frozen_string_literal: true

require 'factory_bot'
require 'fixtures/dummy_user'

FactoryBot.define do
  factory :user, class: 'DummyUser' do
    name { 'John' }
    password { 'password' }
    password_confirmation { 'password' }

    after(:build) do |user, _|
      user.password_digest = BCrypt::Password.create(user.password)
    end
  end
end
