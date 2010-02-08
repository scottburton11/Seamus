module Seamus
  module VideoProcessor
    
    def thumbnail
      Open3.popen3("ffmpeg -y -ss #{start_time} -i '#{self.path}' -t 00:00:01 -vcodec mjpeg -vframes 1 -an -f rawvideo -s #{dimensions_string} - ")[1]
    end
    
    private
    
    def start_time
      (duration || 10000)/3333
    end
    
    def aspect_ratio
      width.to_r/height.to_r
    end
    
    # For ffmpeg dimensions to work, the dimension components have to be even numbers,
    # so odd numbers are coerced to even numbers
    def dimensions_string(constant_width=320)
      "#{constant_width.evenize}x#{(constant_width/aspect_ratio).to_i.evenize}"
    end
    
  end
end