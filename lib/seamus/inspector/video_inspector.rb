module Seamus
  module VideoInspector# < Inspector
    
    def file_attributes
      @file_attributes ||= inspection_attributes
    end

    private

    def inspection_attributes
      attr_hash = {}
      ["audio?", "audio_bitrate", "audio_channels", "audio_channels_string", "audio_codec", "audio_sample_rate", "audio_sample_units", "bitrate", "bitrate_units", "container", "duration", "fps", "height", "video?", "video_codec", "video_colorspace", "width"].each do |attribute|
        attr_hash[attribute.to_s] = media_stat.send(attribute) if media_stat.respond_to?(attribute)
      end
      attr_hash.merge!("size" => self.size)
      return attr_hash
    end

    def media_stat
      RVideo::Inspector.new(:raw_response => raw_response)
    end

    def raw_response
      response = ffmpeg_response_process.read
      ffmpeg_response_process.close
      return response
    end

    def ffmpeg_response_process
      IO.popen("ffmpeg -i '#{self.path}' 2>&1", "r")
    end

  end
end