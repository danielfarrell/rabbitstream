module Rabbitstream
  class Publisher
    attr_reader :actor, :verb, :object, :target

    def initialize(actor, verb, object, target = nil)
      @actor = actor
      @verb = verb
      @object = object
      @target = target
    end

    def publish
      Queue.instance.publish(key, activity)
    end

    def activity
      @activity ||= Activity.new(actor, verb, object, target)
    end

    protected

    def key
      activity.key
    end

  end
end
