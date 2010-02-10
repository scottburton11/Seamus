module Seamus
  module ImageProcessor
    require 'devil'
    
    def thumbnail
      tmp = Tempfile.new(::File.basename(path))
      # io = IO.new
      Devil.load_image(path) do |img|
        img.thumbnail(320)
        img.save("#{path}_#{::File.basename(path)}_thumb.jpg")
      end
      ::File.open("#{path}_#{::File.basename(path)}_thumb.jpg", "r") do |thumb|
        tmp.write thumb.read
      end
       # tmp.close
       tmp.rewind
      # io.close
      ::File.unlink("#{path}_#{::File.basename(path)}_thumb.jpg")
      # return io
      return tmp
    end
      
    
  end
end