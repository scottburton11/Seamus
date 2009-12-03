module Seamus
  class AudioInspector < Inspector
      
    def stats
      inspection_attributes
    end

    private

    def inspection_attributes
      attr_hash = {}
      ["audio?", "audio_bitrate", "audio_channels", "audio_channels_string", "audio_codec", "audio_sample_rate", "audio_sample_units", "bitrate", "bitrate_units", "container", "duration"].each do |attribute|
        attr_hash[attribute.to_s] = media_stat.send(attribute) if media_stat.respond_to?(attribute)
      end
      attr_hash.merge!("size" => file_stat.size)
      return attr_hash
    end

    def media_stat
      RVideo::Inspector.new(:raw_response => raw_response)
    end

    def raw_response
      process = IO.popen("ffmpeg -i '#{file.path}' 2>&1", "r")
      response = process.read
      process.close
      return response
    end
  
    
  end
end