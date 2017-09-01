# frozen_string_literal: true

require 'spec_helper'

module JWTEasy
  RSpec.describe Result do
    describe '#method_missing' do
      let(:result) { described_class.new(payload) }

      context 'when payload is provided as a hash with data and claim keys' do
        let(:payload) { { 'data' => { 'id' => 'some-id' }, 'nbf' => 567_325 } }

        it 'returns the value for a data property that does exist' do
          expect(result.id).to eql(payload['data']['id'])
        end

        it 'raises an error for a data property that does not exist' do
          expect { result.non_exsiting }.to raise_error(NoMethodError)
        end
      end

      context 'when payload is provided as a hash' do
        let(:payload) { { 'id' => 'some-id' } }

        it 'returns the value for a data property that does exist' do
          expect(result.id).to eql(payload['id'])
        end

        it 'raises an error for a data property that does not exist' do
          expect { result.non_exsiting }.to raise_error(NoMethodError)
        end
      end

      context 'when payload is provided but is not a hash' do
        let(:payload) { 'some-identifying-data' }

        it 'raises an error for any ' do
          expect { result.id }.to raise_error(NoMethodError)
        end
      end

      context 'when no payload is provided' do
        let(:payload) { nil }

        it 'raises NoMethodError' do
          expect { result.non_existing }.to raise_error(NoMethodError)
        end
      end
    end

    describe '#data' do
      let(:result) { described_class.new(payload) }

      context 'when payload is provided as a hash with data and claim keys' do
        let(:payload) { { 'data' => { 'id' => 'some-id' }, 'nbf' => 567_325 } }

        it 'returns the value of the payload data key' do
          expect(result.data).to match('id' => 'some-id')
        end
      end

      context 'when payload is provided as a hash with a claim key' do
        let(:payload) { { 'id' => 'some-id', 'exp' => 463_332 } }

        it 'returns the payload data excluding the claim key' do
          expect(result.data).to match('id' => 'some-id')
        end
      end

      context 'when payload is provided but is not a Hash' do
        let(:payload) { 'some-useful-data' }

        it 'returns the original payload' do
          expect(result.data).to eql(payload)
        end
      end

      context 'when payload is not provided' do
        let(:payload) { nil }

        it 'returns nil' do
          expect(result.data).to be_nil
        end
      end
    end

    describe '#claim' do
      let(:result) { described_class.new(payload) }

      context 'when payload contains an expiration time claim key' do
        let(:payload) { { 'id' => 'an-id', 'exp' => 236_232 } }

        it 'returns expiration time for the claim type' do
          expect(result.claim).to eql(CLAIM_EXPIRATION_TIME)
        end
      end

      context 'when payload contains a not before time claim key' do
        let(:payload) { { 'id' => 323_463, 'nbf' => 345_734 } }

        it 'returns not before time for the claim type' do
          expect(result.claim).to eql(CLAIM_NOT_BEFORE_TIME)
        end
      end
    end
  end
end
