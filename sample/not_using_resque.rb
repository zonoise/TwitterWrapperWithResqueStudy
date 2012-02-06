require 'redis'
require 'pp'
require 'json'
require 'yaml'
$:.unshift File::dirname(__FILE__)+'/../lib'
require 'twitter_wrapper'

redis = Redis.new
redis.ping

t = YAML.load_file("./twitter_config.yml")['development']
twitter_conf={
  :consumer_key       => t['consumer_key'],
  :consumer_secret    => t['consumer_secret'],
  :oauth_token        => t['oauth_token'],
  :oauth_token_secret => t['oauth_token_secret'],
}


screen_name = "XXX"
key1 = "XXX"
key2 = "XXX"
list_name="XXX"

TwitterWrapper.get_lists(key1,screen_name ,twitter_conf)
lists = redis.lrange(key1,0 ,-1)
lists.each do |list|
  pp JSON.parse(list)
end

TwitterWrapper.get_list_members(key2,screen_name,list_name,twitter_conf)
members = redis.lrange(key2,0 ,-1)
members.each do |member|
  pp JSON.parse(member)
end

