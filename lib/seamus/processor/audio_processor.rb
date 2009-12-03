module Seamus
  class AudioProcessor < Processor
    
    def thumbnail
      raise ThumbnailError, "invalid type for thumbnail"
    end
    
  end
end