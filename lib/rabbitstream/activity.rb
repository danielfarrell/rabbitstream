require 'active_support/core_ext/string/inflections'

module Rabbitstream
  class Activity
    attr_reader :actor, :verb, :object, :target

    def initialize(actor, verb, object, target = nil)
      @actor = actor
      @verb = verb
      @object = object
      @target = target
    end

    def key
      [actor_type, verb, object_type, target_type].compact.join(".")
    end

    def as_json(options={})
      {
        actor: {object_type: actor_type, id: actor.to_param},
        verb: verb,
        object: {object_type: object_type, id: object.to_param},
        published: Time.now.iso8601
      }.merge(target_hash)
    end

    protected

    def actor_type
      actor.class.to_s.underscore
    end

    def object_type
      object.class.to_s.underscore
    end

    def target_type
      target? ? target.class.to_s.underscore : nil
    end

    def target_hash
      target? ? {target: {object_type: target_type, id: target.to_param}} : {}
    end

    def target?
      !target.nil?
    end

  end
end
