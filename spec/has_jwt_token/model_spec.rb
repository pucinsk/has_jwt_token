# frozen_string_literal: true

require 'spec_helper'

RSpec.describe HasJwtToken::Model do
  let(:model_class) { Dummy::User }

  it 'has got gem config present' do
    expect(model_class.has_jwt_token).to be_present
  end
end
