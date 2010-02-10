module Seamus
  module AudioProcessor
    
    def thumbnail
      raise ThumbnailError, "invalid type for thumbnail"
    end
    
  end
end