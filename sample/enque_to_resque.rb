require 'resque'
require 'pp'
require 'json'
require 'yaml'
require 'redis'
$:.unshift File.dirname(__FILE__) + '/lib'
require 'twitter_wrapper_job'

t = YAML.load_file("./twitter_config.yml")['test']
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


redis = Redis.new
#Redisへの接続確認
redis.ping

#ワーカーが起動しているかチェック
if 1 > Resque::Worker.all.length do
  abort("worker 0")
end

Resque.enqueue(TwitterWrapperJob::GetListsJob,key1,screen_name,twitter_conf)
Resque.enqueue(TwitterWrapperJob::GetListMembersJob,key2,screen_name,list_name,twitter_conf)

