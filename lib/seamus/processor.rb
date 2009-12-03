module Seamus
  class Processor
    attr_reader :file_attributes

    def initialize(file_path, file_attributes)
      @file = File.open(file_path, "r")
      @file_attributes = file_attributes
    end
  end
end