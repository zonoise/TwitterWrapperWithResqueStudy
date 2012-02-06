require 'pp'
require 'json'
require 'redis'

key1 = "XXX"
key2 = "XXX"

redis = Redis.new
redis.ping

lists = redis.lrange(key1,0 ,-1)
lists.each do |l|
  pp JSON.parse(l)
end

members = redis.lrange(key2,0 ,-1)
members.each do |m|
  pp JSON.parse(m)
end
