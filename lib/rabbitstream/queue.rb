require 'bunny'
require 'singleton'
require 'json'

module Rabbitstream
  class Queue
    include Singleton

    attr_reader :connection

    def initialize
      @connection = Bunny.new
      @connection.start
      @channels = {}
      @exchanges = {}
    end

    def publish(key, activity)
      find_exchange.publish(activity.to_json, routing_key: key, persistent: true)
    end

    def create_channel
      @channel = @connection.create_channel
      @exchange = @channel.topic(exchange_name, durable: true)
    end

    protected

    def find_channel
      @channels[Thread.current.object_id] ||= @connection.create_channel
    end

    def find_exchange
      @exchanges[Thread.current.object_id] ||= find_channel.topic(exchange_name, durable: true)
    end

    def exchange_name
      ENV['RABBITMQ_EXCHANGE'] || 'rabbitstream'
    end

  end
end
