module Seamus
  module TextProcessor
    
    def thumbnail
      raise ThumbnailError, "invalid type for thumbnail"
    end
    
  end
end