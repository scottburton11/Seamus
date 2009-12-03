module Seamus
  class VideoProcessor < Processor
    
    def thumbnail
      thumb = thumb_tempfile
      IO.popen("ffmpeg -y -ss #{start_time} -i '#{@file.path}' -t 00:00:01 -vcodec mjpeg -vframes 1 -an -f rawvideo -s #{dimensions_string} - 2> /dev/null") do |io|
        thumb.write io.read
      end
      thumb.close
      return thumb
    end
    
    private
    
    def start_time
      (file_attributes["duration"] || 10000)/3333
    end
    
    # nodoc
    def thumb_tempfile
      Tempfile.new("#{File.basename(@file.path, File.extname(@file.path))}_thumb.jpg")
    end
    
    def aspect_ratio
      width = (file_attributes["width"]).to_f
      height = (file_attributes["height"]).to_f
      return (width/height)
    end
    
    # For ffmpeg dimensions to work, the dimension components have to be even numbers,
    # so odd numbers are coerced to even numbers
    def dimensions_string(constant_width=320)
      "#{constant_width.evenize}x#{(constant_width/aspect_ratio).to_i.evenize}"
    end
    
  end
end