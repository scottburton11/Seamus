module Seamus
  module AudioInspector
      
    def inspector
      @inspector ||= RVideo::Inspector.new(:file => self.path)
    end
    
  end
end