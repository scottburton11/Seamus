module Seamus
  class TextProcessor < Processor
    
    def thumbnail
      raise ThumbnailError, "invalid type for thumbnail"
    end
    
  end
end