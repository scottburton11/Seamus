module Seamus
  class ApplicationProcessor < Processor

    def thumbnail
      raise ThumbnailError, "invalid type for thumbnail"
    end
    
  end
end