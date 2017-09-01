# frozen_string_literal: true

module JWTEasy
  # Encoder object for generating new tokens.
  #
  # * This is usually not instantiated directly, but rather by way of
  #   calling +JWTEasy.encode+.
  class Encoder
    attr_reader :data,
                :configuration

    # Initializes a new encoder instance.
    #
    # * If no configuration object is passed or is +nil+, the value of
    #   +JWTEasy.configuration+ is used as the configuration object
    #
    # @param [Object] data the data to be encoded
    # @param [Configuration] configuration the configuration object
    def initialize(data, configuration = nil)
      @data           = data
      @configuration  = configuration || JWTEasy.configuration
    end

    # Encodes the data with the configured options.
    #
    # @return [String] the encoded token
    def encode
      JWT.encode(payload, configuration.secret, configuration.algorithm)
    end

    # Determines the structure of the payload to be encoded.
    #
    # @return [Object] the payload to be encoded
    def payload
      case configuration.claim
      when CLAIM_EXPIRATION_TIME
        { data: data, exp: expiration_time }
      when CLAIM_NOT_BEFORE_TIME
        { data: data, nbf: not_before_time }
      else
        data
      end
    end

    # Calculates the expiration time if configured.
    #
    # @return [Integer] the expiration time
    def expiration_time
      Time.now.to_i + configuration.expiration_time
    end

    # Calculates the not before time if configured.
    #
    # @return [Integer] the not before time
    def not_before_time
      Time.now.to_i - configuration.not_before_time
    end
  end
end
