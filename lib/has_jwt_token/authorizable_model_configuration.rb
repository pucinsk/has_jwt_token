# frozen_string_literal: true

module HasJwtToken
  class AuthorizableModelConfiguration
    def identificator(value = nil)
      return @identificator unless value

      @identificator = value
    end
  end
end
