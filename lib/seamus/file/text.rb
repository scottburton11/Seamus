module Seamus
  module File    
    class Text < ::File
      include Seamus::TextInspector
      include Seamus::TextProcessor
      include Seamus::StandardAdditions
      def initialize(*args, &block)
        super(*args, &block)
        # create_methods_for inspector
      end
    end
  end
end