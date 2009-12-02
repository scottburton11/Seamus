module Seamus
  class VideoInspector < Inspector

    def initialize(file_path)
      @file = File.new(file_path)
    end

    def stats
      inspection_attributes(stat(@file))
    end

    private

    def inspection_attributes(stat)
      attr_hash = {}
      ["audio?", "audio_bitrate", "audio_channels", "audio_channels_string", "audio_codec", "audio_sample_rate", "audio_sample_units", "bitrate", "bitrate_units", "container", "duration", "fps", "height", "video?", "video_codec", "video_colorspace", "width"].each do |attribute|
        attr_hash[attribute.to_s] = stat.send(attribute) if stat.respond_to?(attribute)
      end
      return attr_hash
    end

    def stat(file)
      RVideo::Inspector.new(:raw_response => raw_response)
    end

    def raw_response
      response = ffmpeg_response_process.read
      ffmpeg_response_process.close
      return response
    end

    def ffmpeg_response_process
      IO.popen("ffmpeg -i '#{@file.path}' 2>&1", "r")
    end

  end
end