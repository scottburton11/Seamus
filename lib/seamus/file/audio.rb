module Seamus
  module File    
    class Audio < ::File
      include Seamus::AudioInspector
      include Seamus::AudioProcessor
      include Seamus::StandardAdditions
      def initialize(*args, &block)
        super(*args, &block)
        create_methods_for inspector, :except => "path"
      end
    end
  end
end