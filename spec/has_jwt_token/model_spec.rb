# frozen_string_literal: true

require 'spec_helper'

RSpec.describe HasJwtToken::Model do
  subject(:model) { build(:user) }

  let(:identificator) { 'name' }

  describe '.has_jwt_token' do
    let(:config) do
      HasJwtToken::AuthorizableModelConfiguration.new
    end

    before do
      config.identificator(identificator)
    end

    it 'has got gem config present' do
      expect(model.class.has_jwt_token.identificator).to eq(config.identificator)
    end
  end

  describe '.authenticate_by_identificator' do
    subject(:authenticate_by_identificator) do
      DummyUser.authenticate_by_identificator(model.name, model.password)
    end

    it 'returns user' do
      expect(authenticate_by_identificator).to eq(model)
    end
  end
end
