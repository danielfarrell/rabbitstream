require 'test_helper'
require 'bunny_mock'

module BunnyMock
  class Channel
    def topic(name, attrs)
      BunnyMock::Exchange.new(name, attrs)
    end
  end
end

require 'rabbitstream/queue'

describe Rabbitstream::Queue do

  before do
    @exchange_name = "local_news"
    ENV["RABBITMQ_EXCHANGE"] = @exchange_name
    bunny = BunnyMock::Bunny.new
    Bunny.stubs(:new).returns(bunny)
    Rabbitstream::Queue.stubs(:instance).returns(Rabbitstream::Queue.send(:new))
    @queue = Rabbitstream::Queue.instance
  end

  it "should publish json to exchange with key" do
    @queue.publish("boring", {story: "dogs"})
  end

end
