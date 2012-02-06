module TwitterWrapperJob
  class GetListsJob
    include TwitterWrapper
    @queue = "get_lists"
    def self.perform(key,screen_name,twitter_conf)
      sleep 10
      TwitterWrapper.get_lists(key,screen_name,twitter_conf)
    end
  end
end
