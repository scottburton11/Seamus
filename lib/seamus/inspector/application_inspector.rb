module Seamus
  class ApplicationInspector < Inspector

    def initialize(file_path)
      @file = File.new(file_path)
    end
      
    def stats
      inspection_attributes(stat(@file))
    end
    
    private

    def stat(file)
      File.stat(file.path)
    end

    def inspection_attributes(stat)
      attr_hash = {"size" => stat.size}
      return attr_hash
    end
    
  end
end