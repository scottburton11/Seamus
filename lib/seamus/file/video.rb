module Seamus
  module File
    class Video < ::File
      include Seamus::VideoInspector
      include Seamus::VideoProcessor
      include Seamus::StandardAdditions
      def initialize(*args, &block)
        super(*args, &block)
        create_methods_for inspector, :except => "path"
      end
    end
  end
end