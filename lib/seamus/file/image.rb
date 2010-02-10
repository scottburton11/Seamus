module Seamus
  module File    
    class Image < ::File
      include Seamus::ImageInspector
      include Seamus::ImageProcessor
      include Seamus::StandardAdditions
      def initialize(*args, &block)
        super(*args, &block)
        create_methods_for inspector, :except => ["thumbnail", "thumbnail2"]
      end
    end
  end
end