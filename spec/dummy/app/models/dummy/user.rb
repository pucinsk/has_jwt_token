# frozen_string_literal: true

module Dummy
  class User < ApplicationRecord
    include HasJwtToken::Model

    def self.table_name_prefix
      'dummy_'
    end

    has_jwt_token do |c|
      c.identificator :name
    end
  end
end
