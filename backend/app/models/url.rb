class Url
  HASH_KEY = 'url_hash'.freeze
  KEY_LENGTH = 6

  def self.all
    REDIS.hgetall(HASH_KEY)
  end

  def self.create(url_to_shorten)
    unique_id = SecureRandom.hex(KEY_LENGTH)

    REDIS.hset(HASH_KEY, unique_id, url_to_shorten)
    unique_id
  end

  def self.for_shortened(shortened_url)
    REDIS.hget(HASH_KEY, shortened_url)
  end

  def self.remove(shortened_url)
    REDIS.hdel(HASH_KEY, shortened_url)
  end
end
