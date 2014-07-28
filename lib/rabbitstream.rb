module Rabbitstream
  autoload :Activity,  'rabbitstream/activity'
  autoload :Publisher, 'rabbitstream/publisher'
  autoload :Queue,     'rabbitstream/queue'

  def self.publish(actor, verb, object, target = nil)
    Publisher.new(actor, verb, object, target).publish
  end
end
