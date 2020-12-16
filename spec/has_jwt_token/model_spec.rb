# frozen_string_literal: true

require 'spec_helper'

RSpec.describe HasJwtToken::Model do
  subject(:model) { build(:user) }

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

  describe '.find_with_jwt' do
    subject(:find_with_jwt) { DummyUser.find_with_jwt(token) }

    context 'when token is valid' do
      let(:token) { model.authenticate(model.password).token }

      it 'returns model record with token', :aggregate_failures do
        expect(find_with_jwt).to be_a(DummyUser)
        expect(find_with_jwt.token).not_to be_blank
      end
    end

    context 'when token is invalid' do
      let(:token) { 'invalid_token' }

      it 'raises an error' do
        expect { find_with_jwt }.to raise_error(HasJwtToken::InvalidToken)
      end
    end
  end
end
