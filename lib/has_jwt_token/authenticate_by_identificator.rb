# frozen_string_literal: true

module HasJwtToken
  module AuthenticateByIdentificator
    def identificator
      has_jwt_token.identificator
    end

    def authenticate_by_identificator(identificator_value, password)
      find_by_identificator(identificator_value).tap do |model|
        model.authenticate(password)
      end
    end

    private

    def find_by_identificator(identificator_value)
      find_by(identificator => identificator_value)
    end
  end
end
