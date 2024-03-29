# JWTEasy

JWTEasy is a simple wrapper for the [JWT](https://github.com/jwt/ruby-jwt) gem (see versions below) that hopes to make generating and consuming various types of JSON web tokens a little easier.

> **Note:** Currently only supports plain, EXP and NBF tokens with HMAC HS256 encryption.

## Usage

Generating a plain token without encryption might look something like:

```ruby
token = JWTEasy.encode(id: 'some-identifying-information')
```

You'd likely want to configure things before though:

```ruby
# config/initializers/jwt_easy.rb
JWTEasy.configure do |config|
 config.expiration_time  = 3_600
 config.secret           = ENV['JWT_EASY_SECRET']
 config.algorithm        = JWTEasy::ALGORITHM_HMAC_HS256
end
````

Of course you're able to consume tokens just as easily:

```ruby
JWTEasy.decode(token).id #=> 'some-identifying-information'
```

### Adding Leeway

For both EXP and NBF claims, you're able to specify the leeway to be used when decoding tokens:

```ruby
JWTEasy.configure do |config|
 config.leeway = 30 # seconds
end
````

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'jwt_easy'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install jwt_easy

## Versions

This gem's version numbers don't track that of the JWT gem, if you require support for a specific JWT gem version, you need to specify the correct version for this gem. 

| jwt_easy | jwt   | Ruby     |
|----------|-------|----------|
| < 1.0.0  | 1.5.x | >= 2.4.x |
| 1.0.0    | 2.7.x | >= 2.5.x |

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/collcoll/jwt-easy.
