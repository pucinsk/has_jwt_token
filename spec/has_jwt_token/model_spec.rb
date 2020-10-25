# frozen_string_literal: true

require 'spec_helper'

RSpec.describe HasJwtToken::Model do
  subject(:model) { build(:user) }

  describe '.has_jwt_token' do
    it 'has got gem config present' do
      expect(model.class.has_jwt_token).to be_a(HasJwtToken::JwtConfiguration)
    end
  end

  shared_examples 'successful authentication' do
    it 'returns model' do
      expect(authenticate).to be_a(model.class)
    end

    it 'returns token' do
      expect(model.token).to  be_present
    end
  end

  shared_examples 'failed authentication' do
    it { is_expected.to be_falsey }

    it 'does not return token' do
      expect(model.token).to be_nil
    end
  end

  describe '#authenticate' do
    subject(:authenticate) { model.authenticate(password) }

    before do
      authenticate
    end

    context 'when password is valid' do
      let(:password) { model.password }

      it_behaves_like 'successful authentication'
    end

    context 'when password is not valid' do
      let(:password) { 'wrong password' }

      it_behaves_like 'failed authentication'
    end
  end

  describe '#autheticate_with_jwt' do
    subject(:authenticate) { model.authenticate_with_jwt(token) }

    before do
      authenticate
    end

    context 'with valid token' do
      let(:token) { model.authenticate(model.password).token }

      it_behaves_like 'successful authentication'
    end

    context 'with ivalid token' do
      let(:token) { 'invalid token' }

      it_behaves_like 'failed authentication'
    end
  end
end
