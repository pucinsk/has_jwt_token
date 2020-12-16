# frozen_string_literal: true

require 'spec_helper'

RSpec.describe HasJwtToken::HasJwtModelConfiguration do
  subject(:model) { build(:user) }

  describe '.has_jwt_token' do
    it 'has got gem config present' do
      expect(model.class.has_jwt_token).to be_a(HasJwtToken::JwtConfiguration)
    end
  end
end
