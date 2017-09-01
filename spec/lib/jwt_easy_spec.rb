# frozen_string_literal: true

require 'spec_helper'

describe JWTEasy do
  subject(:library) { described_class }

  it 'has a version number' do
    expect(JWTEasy::VERSION).not_to be nil
  end

  describe '.configuration' do
    it 'returns a configuration instance' do
      expect(library.configuration).to be_a(JWTEasy::Configuration)
    end
  end

  describe '.configure' do
    it 'yields the configuration object' do
      expect { |b| library.configure(&b) }.to yield_with_args(library.configuration)
    end
  end
end
