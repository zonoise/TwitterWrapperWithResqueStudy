require 'twitter'
require 'redis'
require 'json'
module TwitterWrapper
  def self.get_list_members(key,screen_name,list_slug,twitter_conf)

    Twitter.configure do |config|
      config.consumer_key = twitter_conf[:consumer_key]
      config.consumer_secret = twitter_conf[:consumer_secret]
      config.oauth_token = twitter_conf[:oauth_token]
      config.oauth_token_secret = twitter_conf[:oauth_token_secret]
    end

    redis = Redis.new

    #max listmember 500 and per request 20 member
    if 25 >= Twitter.rate_limit_status.remaining_hits
      return false
    end

    next_cursor='-1'

    while next_cursor != 0 do
      members = Twitter.list_members(screen_name,list_slug,{'cursor'=>next_cursor,'skip_status'=>true})
      next_cursor = members['next_cursor']
      #we need only id and screen_name
      members['users'].each do |member|
        redis.rpush(key,{'id'=>member['id'],'screen_name'=> member['screen_name']}.to_json)
      end
    end
    return true
  end
end
