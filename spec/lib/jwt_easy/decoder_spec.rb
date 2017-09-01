# frozen_string_literal: true

require 'spec_helper'

module JWTEasy
  RSpec.describe Decoder do
    subject(:decoder) { described_class.new(token, configuration) }

    let(:configuration) { nil }

    describe '#verification?' do
      subject { decoder.verification? }

      let(:token) { 'a-generated-token' }

      context 'when a default configuration is provided' do
        it { is_expected.to be(false) }
      end

      context 'when a secret has been configured' do
        let(:configuration) do
          Configuration.new.tap do |configuration|
            configuration.secret = 'a-secret'
          end
        end

        it { is_expected.to be(true) }
      end
    end

    describe '#headers' do
      subject { decoder.headers }

      let(:token) { 'a-generated-token' }

      context 'when a default configuration is provided' do
        it { is_expected.not_to include(:algorithm) }
      end

      context 'when a secret and algorithm has been configured' do
        let(:configuration) do
          Configuration.new.tap do |configuration|
            configuration.secret = 'a-secret'
            configuration.algorithm = ALGORITHM_HMAC_HS256
          end
        end

        it { is_expected.to include(algorithm: ALGORITHM_HMAC_HS256) }
      end

      context 'when expiration time has been configured' do
        let(:configuration) do
          Configuration.new.tap do |configuration|
            configuration.expiration_time = 234_325
          end
        end

        it { is_expected.to include(validate_exp: true) }
      end

      context 'when not before time has been configured' do
        let(:configuration) do
          Configuration.new.tap do |configuration|
            configuration.not_before_time = 567_342
          end
        end

        it { is_expected.to include(validate_nbf: true) }
      end
    end

    describe '#decode' do
      let(:payload) { { 'id' => 'some-useful-info' } }

      context 'when a default configuration is provided' do
        let(:token) { JWT.encode(payload, nil, 'none') }

        it 'decodes with no verification, validation or algorithm' do
          expect(JWT).to receive(:decode).with(token, nil, false, {})
          decoder.decode
        end

        it 'instantiates a new result with the decoded payload' do
          expect(Result).to receive(:new).with(payload, anything)
          decoder.decode
        end

        it 'returns the newly instantiated result' do
          expect(decoder.decode).to be_a(Result)
        end
      end

      context 'when a default configuration is provided' do
        let(:token) { JWT.encode(payload, nil, 'none') }

        it 'decodes with no verification, validation or algorithm' do
          expect(JWT).to receive(:decode).with(token, nil, false, {})
          decoder.decode
        end

        it 'instantiates a new result with the decoded payload' do
          expect(Result).to receive(:new).with(payload, anything)
          decoder.decode
        end

        it 'returns the newly instantiated result' do
          expect(decoder.decode).to be_a(Result)
        end
      end
    end
  end
end
