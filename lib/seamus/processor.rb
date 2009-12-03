module Seamus
  class Processor
    attr_reader :file, :file_attributes

    def initialize(file_path, file_attributes)
      @file = File.open(file_path, "r")
      @file_attributes = file_attributes
    end
    
    # nodoc
    def thumb_tempfile
      Tempfile.new("#{File.basename(@file.path, File.extname(@file.path))}_thumb.jpg")
    end
    
  end
end