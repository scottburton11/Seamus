module Seamus
  class Inspector
    attr_reader :file

    def initialize(file_path)
      @file = File.open(file_path, "r")
    end
    
    def stats
      raise RuntimeError, "method called on base class"
    end
    
    private    
    
    def file_stat
      File::Stat.new(file.path)
    end

  end
end