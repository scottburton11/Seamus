$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
require 'rubygems'
require 'Seamus'
require 'spec'
require 'spec/autorun'
require 'fakefs/spec_helpers'
require 'factories'

Spec::Runner.configure do |config|
  include Factories
end
