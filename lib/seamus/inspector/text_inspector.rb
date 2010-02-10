module Seamus
  module TextInspector
    
    def words
      characters.scan(/\S+/)
    end
    
    def word_count
      words.size
    end
    
    def lines
      characters.scan(/.*\n/)
    end
    
    def lines_count
      lines.size
    end
    
    private
    
    def characters
      @characters ||= ::File.read(self.path)
    end
  end
end