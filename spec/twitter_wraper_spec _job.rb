require 'rspec'
require 'mock_redis'
require '../lib/twitter_wrapper_job'

describe TwitterWrapper do

  context "not login"
    it "get_lists" do
      pending
    end
    it "get_list_members" do
    end
  end

  context "login"
    context "enough api remaining-hits"
      it "get_lists" do
        pending
      end
      it "get_list_members" do
        pending
      end
    end
    context "short of api remaining-hits"
      it "get_lists" do
        pending
      end
      it "get_list_members" do
        pending
      end
    end
  end
end
