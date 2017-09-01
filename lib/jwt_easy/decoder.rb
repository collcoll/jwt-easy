# frozen_string_literal: true

module JWTEasy
  # Decoder object for decoding tokens.
  #
  # * This is usually not instantiated directly, but rather by way of
  #   calling +JWTEasy.decode+.
  class Decoder
    attr_reader :token,
                :configuration

    # Initializes a new encoder instance.
    #
    # * If no configuration object is passed or is +nil+, the value of
    #   +JWTEasy.configuration+ is used as the configuration object
    #
    # @param [String] token the token to be decoded
    # @param [Configuration] configuration the configuration object
    def initialize(token, configuration = nil)
      @token          = token
      @configuration  = configuration || JWTEasy.configuration
      @headers        = {}
    end

    # Decodes the token with the configured options.
    #
    # @return [Result] the result of the decoding
    def decode
      Result.new(*JWT.decode(token, configuration.secret, verification?, headers))
    end

    # Determines if verification will be used during decoding.
    #
    # @return [Boolean] if verification will be used or not
    def verification?
      configuration.secret.nil? == false
    end

    # Determines the headers to be used during decoding.
    #
    # @return [Hash] the headers to be used
    def headers
      @headers.tap do |headers|
        headers[:algorithm] = configuration.algorithm if verification?

        case configuration.claim
        when CLAIM_EXPIRATION_TIME
          headers[:validate_exp] = true
        when CLAIM_NOT_BEFORE_TIME
          headers[:validate_nbf] = true
        end
      end
    end
  end
end
