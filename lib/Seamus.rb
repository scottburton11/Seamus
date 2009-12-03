require 'rvideo'
require 'digest/md5'

require 'tempfile'

$LOAD_PATH << './lib'

require 'core/numeric'
require 'seamus/inspector'
require 'seamus/inspector/video_inspector'
require 'seamus/inspector/audio_inspector'
require 'seamus/inspector/image_inspector'
require 'seamus/inspector/application_inspector'
require 'seamus/processor'
require 'seamus/processor/video_processor'
require 'seamus/processor/audio_processor'
require 'seamus/processor/image_processor'
require 'seamus/processor/application_processor'
require 'mime_table'


## Seamus - The File Inspector
# Mix Seamus in to your class and get a hash of #file_attributes appropriate to the file type.
# Provide an instance of File, or any class that responds to #path, and include Seamus:
#
#   class MyClass
#     include Seamus
#     attr_accessor :file
#     
#     def initialize(path)
#       @path = File.open(path)
#     end
#   end
#   
#   my_file = MyClass.new("path/to/file.mov")
#   my_file.file_attributes
#   
#   # => {"video_codec"=>"h264", "bitrate_units"=>"kb/s", "container"=>"mov,mp4,m4a,3gp,3g2,mj2", "audio_channels_string"=>"stereo", "audio?"=>true, "audio_channels"=>2, "video?"=>true, "audio_sample_rate"=>44100, "bitrate"=>346, "audio_codec"=>"mpeg4aac", "video_colorspace"=>"yuv420p", "height"=>576, "audio_sample_units"=>"Hz", "fps"=>"7.00", "duration"=>84000, "width"=>1024}
#   
#
# Generate thumbnails automatically:
# 
#   my_file.thumbnail {|thumb| my_open_file_instance.write thumb.read }
#   
  

module Seamus

  module ClassMethods

  end

  module InstanceMethods

    def file_path
      file.path
    end

    def file_name
      File.basename(file_path)
    end

    def file_attributes
      @file_attributes ||= inspect_file
    end

    def md5
      @md5 ||= Digest::MD5.file(file_path)
    end

    def md5_hex_string
      md5.to_s
    end

    def md5_base64_encoded
      Base64.encode64(md5.digest).strip
    end

    def content_type
       MimeTable.lookup_by_extension(extension).to_s
    end

    def thumbnail(&block)
      @thumbnail ||= generate_thumbnail
      if block_given?
        begin
          @thumbnail.open
          yield @thumbnail
        ensure
          @thumbnail.close
        end
      end
      return @thumbnail
    end

    protected

    def inspect_file
      inspector = Seamus.const_get("#{file_type.classify}Inspector").new(file_path)
      return inspector.stats
    end

    def generate_thumbnail
      processor = Seamus.const_get("#{file_type.classify}Processor").new(file_path, file_attributes)
      begin
        processor.thumbnail
      rescue ThumbnailError => e
        return nil
      rescue NameError
        return nil
      end
    end

    private

    def file_type
      # begin
      #   @file_attributes["content-type"].split("/").first
      # rescue
        determine_type_from_extension
      # end
    end

    def determine_type_from_extension
      begin
        Mime::Type.lookup_by_extension(extension).to_s.split("/").first
      rescue NoMethodError
        "application"
      rescue NameError
        if MimeTable
          MimeTable.lookup_by_extension(extension).to_s.split("/").first
        else
          raise LoadError, "Mime module not loaded"
        end
      end
    end

    # returns the last segment of the filename, eg "foo.mov".extension => ".mov"
    def extension
      file_name.split('.').last.downcase
    end

    # Add file_attributes as getter methods
    def method_missing(method, *args, &block)
      if file_attributes.include?(method.to_s)
        file_attributes[method.to_s]
      else
        super(method, *args, &block)
      end
    end

  end



  def self.included(receiver)
    receiver.extend         ClassMethods
    receiver.send :include, InstanceMethods
  end

end



class ThumbnailError < Exception
  
end