# frozen_string_literal: true

require_relative 'lib/has_jwt_token/version'

Gem::Specification.new do |spec|
  spec.name          = 'has_jwt_token'
  spec.version       = HasJwtToken::VERSION
  spec.authors       = ['Jokūbas Pučinskas']
  spec.email         = ['j.pucinskas@gmail.com']

  spec.summary = 'Fast running JWT implentation for Rails apps!'
  spec.description = 'JWTails provides JWT authetication'\
    'for models which are kean to use `has_secure_password`'\
    'in Rails app. It allows find resource by some identificator'\
    'and password of by JWT token itself.'
  spec.homepage      = 'https://github.com/pucinsk'
  spec.license       = 'MIT'
  spec.required_ruby_version = Gem::Requirement.new('>= 2.7.0')

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/pucinsk'
  spec.metadata['changelog_uri'] = 'https://github.com/pucinsk'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'bcrypt'
  spec.add_dependency 'jwt'
  spec.add_dependency 'rails', '>= 5.0', '< 7.0'

  spec.add_development_dependency 'factory_bot'
  spec.add_development_dependency 'pry'
  spec.add_development_dependency 'rubocop'
  spec.add_development_dependency 'rubocop-performance'
  spec.add_development_dependency 'rubocop-rspec'
  spec.add_development_dependency 'simplecov'
end
