require 'devil'

module Seamus
  module ImageInspector
    
    def inspector
      @inspector ||= Devil.load_image(self.path)
    end
    
  end
end