# frozen_string_literal: true

require 'jwt'
require 'jwt_easy/core_ext/hash'
require 'jwt_easy/constants'
require 'jwt_easy/encoder'
require 'jwt_easy/configuration'
require 'jwt_easy/result'
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
end
