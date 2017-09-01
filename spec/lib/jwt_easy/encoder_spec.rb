# frozen_string_literal: true

require 'spec_helper'

module JWTEasy
  RSpec.describe Encoder do
    subject(:encoder) { described_class.new(data, configuration) }

    let(:configuration) { nil }

    describe '#payload' do
      let(:data) { 'some-information' }

      context 'when a default configuration is provided' do
        it 'returns the provided data' do
          expect(encoder.payload).to be(data)
        end
      end

      context 'when configured with an expiration time' do
        let(:expiration_time) { 235_234 }

        let(:configuration) do
          Configuration.new.tap do |configuration|
            configuration.expiration_time = expiration_time
          end
        end
        it 'returns a hash with the provided data' do
          expect(encoder.payload).to include(data: data)
        end

        it 'returns a hash with an expiration time' do
          Timecop.freeze do
            expect(encoder.payload).to include(exp: Time.now.to_i + expiration_time)
          end
        end
      end

      context 'when configured with not before time' do
        let(:not_before_time) { 573_232 }

        let(:configuration) do
          Configuration.new.tap do |configuration|
            configuration.not_before_time = not_before_time
          end
        end

        it 'returns a hash with the provided data' do
          expect(encoder.payload).to include(data: data)
        end

        it 'returns a hash with not before time' do
          Timecop.freeze do
            expect(encoder.payload).to include(nbf: Time.now.to_i - not_before_time)
          end
        end
      end
    end

    describe '#encode' do
      let(:data) { 'some-information' }

      context 'when a default configuration is provided' do
        let(:encoder) { described_class.new(data, nil) }

        it 'encodes the provided data with no claim or algorithm' do
          expect(JWT).to receive(:encode).with(data, nil, 'none')
          encoder.encode
        end
      end

      context 'when configured to use the HMAC HS256 algorithm' do
        let(:secret) { 'keep-it-a-secret' }

        before do
          JWTEasy.configure do |configuration|
            configuration.algorithm = ALGORITHM_HMAC_HS256
            configuration.secret = secret
          end
        end

        it 'encodes the provided data with no claim using HMAC HS256' do
          expect(JWT).to receive(:encode).with(data, secret, 'HS256')
          encoder.encode
        end
      end
    end
  end
end
