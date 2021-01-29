RSpec.configure do |config|
  config.before(:each) { REDIS.flushdb }
  config.after(:each) { REDIS.quit }
end
