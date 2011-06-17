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
    
    def inspection_attributes
      @inspection_attributes ||= [:words, :word_count, :lines, :line_count] + standard_attributes
    end
    
  end
end