require 'rails_helper'
require 'redis_helper'

describe Url do
  let!(:redis) { REDIS }

  subject { Url }

  describe '.all' do
    let!(:test_urls) do
      [
        Url.create('deliveroo.co.uk'),
        Url.create('google.com'),
        Url.create('facebook.com'),
      ]
    end

    it 'returns all urls' do
      expect(subject.all.keys.count).to eq(3)
      expect(subject.all.keys).to eq(test_urls)
    end
  end

  describe '.create' do
    before do
      allow(SecureRandom).to receive(:hex).with(Url::KEY_LENGTH).and_return(expected_hex)
    end

    let(:expected_hex) { 'a' * (Url::KEY_LENGTH * 2) }
    let(:test_url) { 'url-to-be-added.com' }
    let(:hash) { subject.create(test_url) }

    it 'creates hash key with correct format' do
      expect(hash.length).to be(Url::KEY_LENGTH * 2)
      expect(hash).to be(expected_hex)
    end

    it 'creates an entry in redis' do
      expect(redis.hget(Url::HASH_KEY, hash)).to eq(test_url)
    end
  end

  describe '.for_shortened' do
    let(:test_url) { 'to-be-short.com' }

    it 'retrieves correct url for key from redis' do
      shortened_url_key = subject.create(test_url)
      expect(subject.for_shortened(shortened_url_key)).to eq(test_url)
      expect(redis.hget(Url::HASH_KEY, shortened_url_key)).to eq(test_url)
    end
  end

  describe '.remove' do
    let(:test_url) { 'to-be-removed.com' }
    let(:shortened_url_key) { subject.create(test_url) }

    it 'removes the entry from redis' do
      subject.remove(test_url)
      expect(redis.hget(Url::HASH_KEY, test_url)).to eq(nil)
    end
  end
end
