module Seamus
  module File    
    class Application < ::File
      include Seamus::ApplicationInspector
      include Seamus::ApplicationProcessor
      include Seamus::StandardAdditions
      def initialize(*args, &block)
        super(*args, &block)
        # create_methods_for inspector
      end
    end
  end
end