require 'rvideo'
require 'forwardable'

module Seamus
  module VideoInspector
    
    def inspector
      @inspector ||= RVideo::Inspector.new(:file => self.path)
    end

  end
end