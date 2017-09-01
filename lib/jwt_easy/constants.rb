# frozen_string_literal: true

module JWTEasy
  # Short-names for various supported claim types.
  #
  CLAIM_EXPIRATION_TIME = :exp
  CLAIM_NOT_BEFORE_TIME = :nbf

  # Algorithm identifiers for supported algorithms.
  #
  ALGORITHM_HMAC_HS256  = 'HS256'
end
