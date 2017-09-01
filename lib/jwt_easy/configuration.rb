# frozen_string_literal: true

module JWTEasy
  # A configuration object used to define various options for encoding and decoding tokens.
  #
  # * This is usually not instantiated directly, but rather by way of calling
  #   +JWTEasy.configure+.
  class Configuration
    attr_writer :algorithm

    attr_accessor :secret,
                  :expiration_time,
                  :not_before_time

    # Gets the algorithm to use when encoding tokens
    #
    # * If no secret has been set, this returns 'none'
    #
    # @return [String] the algorithm to be used
    def algorithm
      secret ? (@algorithm || ALGORITHM_HMAC_HS256) : 'none'
    end

    # Infers the claim to observe during encoding or decoding.
    #
    # @return [Symbol] short name for the identified claim
    def claim
      if expiration_time
        CLAIM_EXPIRATION_TIME
      elsif not_before_time
        CLAIM_NOT_BEFORE_TIME
      end
    end
  end
end
