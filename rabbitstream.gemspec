$:.unshift File.expand_path("../lib", __FILE__)
require "rabbitstream/version"

Gem::Specification.new do |gem|
  gem.name     = "rabbitstream"
  gem.version  = Rabbitstream::VERSION

  gem.author   = "Daniel Farrell"
  gem.email    = "danielfarrell76@gmail.com"
  gem.homepage = "http://github.com/danielfarrell/rabbitstream"
  gem.summary  = "Publish activities to RabbitMQ"

  gem.description = gem.summary

  gem.files = Dir["**/*"].select { |d| d =~ %r{^(README|bin/|lib/)} }

  gem.add_dependency 'bunny'
  gem.add_dependency 'activesupport'
  gem.add_dependency 'json'

end
