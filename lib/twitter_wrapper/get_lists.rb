require 'twitter'
require 'redis'
require 'json'
module TwitterWrapper
  def self.get_lists(key,screen_name,twitter_conf)

    Twitter.configure do |config|
      config.consumer_key = twitter_conf[:consumer_key]
      config.consumer_secret = twitter_conf[:consumer_secret]
      config.oauth_token = twitter_conf[:oauth_token]
      config.oauth_token_secret = twitter_conf[:oauth_token_secret]
    end

    if 1 >= Twitter.rate_limit_status.remaining_hits
      return false
    end
    next_cursor='-1'
    redis = Redis.new

    while next_cursor != 0 do
      lists = Twitter.lists(screen_name,{'cursor'=>next_cursor})
      next_cursor = lists['next_cursor']
      lists['lists'].each do |list|
        redis.rpush(key,{'id'=>list['id'],'slug'=>list['slug'],'member_count'=>list['member_count']}.to_json)
      end
    end
    return true
  end
end
