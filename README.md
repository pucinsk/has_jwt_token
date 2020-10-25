# HasJwtToken

HasJwtToken provides JWT authetication for models which are kean to use `has_secure_password` in Rails app and wants to use it to grant jwt tokens.

This gem is build on top of [Ruby's JWT](https://github.com/jwt/ruby-jwt) gem and it implements `JWT.encode` and `JWT.decode` methods.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'has_jwt_token'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install has_jwt_token

## Usage
To get started add `HasJwtToken::Model` into your model and configure gem using `has_jwt_token`.

```ruby
class User
  include HasJwtToken::Model

  attr_accessor :name, :password_digest

  has_jwt_token do |jwt|
    jwt.algorithm 'HS256'
    jwt.payload_attribute :name
    jwt.secret 'secret'

    jwt.expiration_time -> { Time.now.to_i + 60 }
    jwt.not_before_time -> { Time.now.to_i }
    jwt.issued_at -> { Time.now.to_i }
    jwt.jwt_id -> { SecureRandom.hex }
    jwt.issuer :dummy_app
    jwt.audience :client_app
    jwt.subject :dummy_app
  end
end

user = User.last

user.authenicate(password) # => user with @token
user.auhtenticate_with_jwt(token) # => user with @token
```

## Roadmap
* Add blacklisted tokens managment
* Remove Rails depedency

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/has_jwt_token. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/[USERNAME]/has_jwt_token/blob/master/CODE_OF_CONDUCT.md).


## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the HasJwtToken project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/has_jwt_token/blob/master/CODE_OF_CONDUCT.md).
