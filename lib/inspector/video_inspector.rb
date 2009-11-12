module Seamus
  
  class VideoInspector
    
    def initialize(file_path)
      @file = File.new(file_path)
    end

    def stats
      inspection_attributes(stat(@file))
    end

    private

    def inspection_attributes(stat)
      attr_hash = {}
      ["audio?", "audio_bitrate", "audio_channels", "audio_channels_string", "audio_codec", "audio_sample_rate", "audio_sample_units", "bitrate", "bitrate_units", "container", "duration", "fps", "height", "path", "video?", "video_codec", "video_colorspace", "width"].each do |attribute|
        attr_hash[attribute.to_s] = stat.send(attribute) if stat.respond_to?(attribute)
      end
      return attr_hash
    end

    def stat(file)
      RVideo::Inspector.new(:raw_response => raw_response(file))
    end

    def raw_response(file)
      process = IO.popen("ffmpeg -i '#{file.path}' 2>&1", "r")
      response = process.read
      process.close
      return response
    end
    
  end
  
end