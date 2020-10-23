# frozen_string_literal: true

require 'spec_helper'

RSpec.describe HasJwtToken::Model do
  subject(:model) { build(:user) }

  describe '.has_jwt_token' do
    it 'has got gem config present' do
      expect(model.class.has_jwt_token).to be_a(HasJwtToken::JwtConfiguration)
    end
  end

  describe '#authenticate' do
    subject(:authenticate) { model.authenticate(password) }

    let(:token) { 'token' }

    before do
      allow(JWT).to receive(:encode).and_return(token)
      authenticate
    end

    context 'when password is valid' do
      let(:password) { model.password }

      it 'returns model' do
        expect(authenticate).to be_a(model.class)
      end

      it 'returns token' do
        expect(model.token).to eq(token)
      end
    end

    context 'when password is not valid' do
      let(:password) { 'wrong password' }

      it { is_expected.to be_falsey }

      it 'does not return token' do
        expect(model.token).to be_nil
      end
    end
  end
end
