module Seamus
  class ImageProcessor < Processor
    require 'devil'
    
    def thumbnail
      tmp = thumb_tempfile
      Devil.load_image(file.path) do |img|
        img.thumbnail(320)
        img.save("#{file.path}_#{File.basename(file.path)}_thumb.jpg")
      end
      File.open("#{file.path}_#{File.basename(file.path)}_thumb.jpg", "r") do |thumb|
        tmp.write thumb.read
      end
      tmp.close
      File.unlink("#{file.path}_#{File.basename(file.path)}_thumb.jpg")
      return tmp
    end
    
    
  end
end