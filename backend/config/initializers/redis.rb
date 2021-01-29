db_number = Rails.env.development? ? 0 : 1
puts "Selecting redis db at index #{db_number} based on Rails.env (#{Rails.env})"
REDIS = Redis.new(host: ENV['IS_DOCKER'] ? 'redis' : 'localhost', db: db_number)
