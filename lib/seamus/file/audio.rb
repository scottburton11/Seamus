module Seamus
  module File    
    class Audio < ::File
      include Seamus::AudioInspector
      include Seamus::AudioProcessor
      include Seamus::StandardAdditions
      def initialize(*args, &block)
        super(*args, &block)
        create_methods_for inspector, :except => [:filename, :path, :full_filename, :raw_response, :raw_metadata, :ffmpeg_binary, :ffmpeg_binary=]
      end
      
      def inspection_attributes
        @inspection_attributes ||= [:valid?, :invalid?, :unknown_format?, :unreadable_file?, :audio?, :video?, :container, :raw_duration, :duration, :bitrate, :bitrate_units, :audio_bit_rate, :audio_stream, :audio_codec, :audio_sample_rate, :audio_sample_units, :audio_channels_string, :audio_channels, :audio_stream_id, :video_stream, :video_stream_id, :video_codec, :video_colorspace, :width, :height, :resolution, :fps] + standard_attributes
      end
      
    end
  end
end