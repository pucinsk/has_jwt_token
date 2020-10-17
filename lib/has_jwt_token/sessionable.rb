module HasJwtToken
  module Sessionable
    def sessionable
      @session_config ||= AuthorizableModelConfiguration.new
      yield(@session_config) if block_given?
      @session_config
    end
  end
end
