module TwitterWrapperJob
  class GetListMembersJob
    
    @queue = "get_list_members"
    def self.perform(key,screen_name,list_slig,twitter_conf)
      TwitterWrapper.get_list_members(key,screen_name,list_slig,twitter_conf)
    end
  end
end
