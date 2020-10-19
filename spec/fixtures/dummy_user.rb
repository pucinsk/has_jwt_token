module HasSecurePassword
  def has_secure_password
    puts 'nice'
  end
end

class BaseClass
  extend HasSecurePassword
end

class DummyUser < BaseClass
  include HasJwtToken::Model

  has_jwt_token do |c|
    c.identificator 'name'
  end
end
