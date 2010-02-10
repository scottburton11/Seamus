module Seamus
  module ApplicationProcessor

    def thumbnail
      raise ThumbnailError, "invalid type for thumbnail"
    end
    
  end
end