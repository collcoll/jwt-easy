# frozen_string_literal: true

require 'jwt'
require 'jwt_easy/core_ext/hash'
require 'jwt_easy/constants'
require 'jwt_easy/encoder'
require 'jwt_easy/configuration'
require 'jwt_easy/result'
require 'jwt_easy/decoder'
require 'jwt_easy/version'

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
