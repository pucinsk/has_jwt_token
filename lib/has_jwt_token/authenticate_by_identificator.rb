# frozen_string_literal: true

require 'active_support/core_ext/module/delegation'

module HasJwtToken
  module AuthenticateByIdentificator
    delegate :identificator, to: :sessionable

    def authenticate_by_identificator(identificator_value, _password)
      find_by(identificator: identificator_value)
    end

    private

    def find_by_identificator(identificator_value)
      find_by(identificator => identificator_value)
    end
  end
end
