# frozen_string_literal: true

require 'jwt'
require 'jwt_easy/core_ext/hash'
require 'jwt_easy/constants'
require 'jwt_easy/encoder'
require 'jwt_easy/configuration'
require 'jwt_easy/result'
require 'jwt_easy/decoder'
require 'jwt_easy/version'

# JWTEasy is a simple wrapper for the JWT gem that hopes to make generating and consuming various
# types of JSON web tokens a little easier.
#
# == Usage
#
# Generating a plain token without encryption might look something like:
#
#    token = JWTEasy.encode(id: 'some-identifying-information')
#
# You'd likely want to configure things before though:
#
#    # config/initializers/jwt_easy.rb
#    JWTEasy.configure do |config|
#      config.not_before_time  = 3_600
#      config.secret           = ENV['JWT_EASY_SECRET']
#      config.algorithm        = JWTEasy::ALGORITHM_HMAC_HS256
#    end
#
# Of course you're able to consume tokens just as easily:
#
#    JWTEasy.decode(token).id #=> 'some-identifying-information'
#
# @see JWTEasy.encode
# @see JWTEasy.decode
# @see JWTEasy.configure
module JWTEasy
  module_function

  # Gets the configuration object.
  #
  # If none was set, a new configuration object is instantiated and returned.
  #
  # @return [Configuration] the configuration object
  #
  # @see Configuration
  def configuration
    @configuration ||= Configuration.new
  end

  # Allows for configuring the library using a block.
  #
  # @example Configuration using a block
  #   JWTEasy.configure do |config|
  #     # ...
  #   end
  #
  # @see Configuration
  def configure
    yield(configuration) if block_given?
  end

  # Instantiates a new encoder and encodes the provided data and the global configuration object.
  #
  # @example Generate a token from some data
  #   JWTEasy.encode(id: 'some-identifying-information')
  #
  # @param [Object] data the data to be encoded in the token
  #
  # @return [String] JSON web token
  #
  # @see Encoder
  def encode(data)
    Encoder.new(data, configuration).encode
  end

  # Instantiates a new decoder with the provided data and the global configuration object.
  #
  # @example Decode a token
  #   JWTEasy.decode(token)
  #
  # @param [String] token the token to be decoded
  #
  # @return [Result] Result of the decode
  #
  # @see Encoder
  def decode(token)
    Decoder.new(token, configuration).decode
  end
end
