# frozen_string_literal: true

require 'factory_bot'
require 'fixtures/dummy_user'

FactoryBot.define do
  factory :user, class: 'DummyUser' do
    name { 'John' }
    password { 'password' }
  end
end
