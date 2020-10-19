# frozen_string_literal: true

require 'spec_helper'
require 'fixtures/dummy_user'

RSpec.describe HasJwtToken::Model do
  let(:model) { DummyUser.new }
  let(:identificator) { 'name' }
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
