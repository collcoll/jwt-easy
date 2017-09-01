# frozen_string_literal: true

require 'spec_helper'

module JWTEasy
  RSpec.describe Configuration do
    let(:configuration) { described_class.new }

    describe '#algorithm' do
      context 'when a secret is present' do
        let(:secret) { 'a-test-secret' }

        before { configuration.secret = secret }

        context 'and an algorithm is present' do
          let(:algorithm) { 'a-test-algorithm' }

          before { configuration.algorithm = algorithm }

          it 'returns the configured algorithm' do
            expect(configuration.algorithm).to eql(algorithm)
          end
        end

        context 'but an algorithm is not present' do
          before { configuration.algorithm = nil }

          it 'returns the default algorithm' do
            expect(configuration.algorithm).to eql(ALGORITHM_HMAC_HS256)
          end
        end
      end

      context 'when a secret is not present' do
        before { configuration.secret = nil }

        context 'and an algorithm is present' do
          let(:algorithm) { 'a-test-algorithm' }

          before { configuration.algorithm = algorithm }

          it 'returns none for the algorithm' do
            expect(configuration.algorithm).to eql('none')
          end
        end
      end
    end

    describe '#claim' do
      context 'when no claim related configuration is present' do
        it 'returns nil for the claim type' do
          expect(configuration.claim).to be_nil
        end
      end

      context 'when expiration time is present' do
        before { configuration.expiration_time = 3_600 }

        it 'returns expiration time for the claim type' do
          expect(configuration.claim).to eql(CLAIM_EXPIRATION_TIME)
        end
      end

      context 'when not before time is present' do
        before { configuration.not_before_time = 3_600 }

        it 'returns not before time for the claim type' do
          expect(configuration.claim).to eql(CLAIM_NOT_BEFORE_TIME)
        end
      end
    end
  end
end
