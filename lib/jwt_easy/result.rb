# frozen_string_literal: true

module JWTEasy
  # Result object that represents a decoded token.
  #
  # * This is usually not instantiated directly, but rather by way of
  #   calling +JWTEasy.encode+.
  class Result
    CLAIM_KEYS = [
      CLAIM_EXPIRATION_TIME,
      CLAIM_NOT_BEFORE_TIME
    ].freeze

    attr_reader :payload,
                :headers

    # Initializes a new result instance.
    #
    # @param [Object] payload from decoding a token
    # @param [Hash] headers from decoding a token
    def initialize(payload = nil, headers = nil)
      @payload = payload
      @headers = headers
    end

    # Determines the encoded data from the payload structure.
    #
    # * If the payload is a hash that contains a claim key alongside other data
    #    attributes, only a hash with the data attributes will be returned.
    #
    # * If the payload is hash that contains data in a data attribute alongside
    #   any claim keys, the value of the data attribute is returned.
    #
    # * If the payload is anything but a hash, the payload is returned.
    #
    # @return [Object] the data encoded with the payload
    def data
      @data ||= if payload.is_a?(Hash)
                  if claim && payload.key?('data')
                    payload['data']
                  else
                    payload.except(*CLAIM_KEYS.map(&:to_s))
                  end
                else
                  payload
                end
    end

    # Infers the claim that was observed during decoding.
    #
    # @return [Symbol] short name for the identified claim
    def claim
      @claim ||= CLAIM_KEYS.find { |claim| payload&.key?(claim.to_s) }
    end

    def method_missing(method, *arguments, &block)
      data.is_a?(Hash) && data.key?(method.to_s) ? data[method.to_s] : super
    end

    def respond_to_missing?(method, _include_private = false)
      (data.is_a?(Hash) && data.key?(method.to_s)) || super
    end
  end
end
