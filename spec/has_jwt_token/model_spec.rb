require 'spec_helper'

RSpec.describe HasJwtToken::Model do
  subject(:model) { dummy_class.new }

  let(:dummy_class) do
    class Dummy
      include described_class

      has_jwt_token
    end
  end

  it 'is awesome' do
    expect(true).to be(false)
  end
end
