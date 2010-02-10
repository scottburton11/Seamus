require 'digest/md5'
require 'open3'
require 'tempfile'

$LOAD_PATH << './lib'

require 'core/numeric'
require 'seamus/standard_additions'
require 'seamus/inspector'
require 'seamus/inspector/video_inspector'
require 'seamus/inspector/audio_inspector'
require 'seamus/inspector/image_inspector'
require 'seamus/inspector/application_inspector'
require 'seamus/inspector/text_inspector'
require 'seamus/processor'
require 'seamus/processor/video_processor'
require 'seamus/processor/audio_processor'
require 'seamus/processor/image_processor'
require 'seamus/processor/application_processor'
require 'seamus/processor/text_processor'
require 'seamus/file/video'
require 'seamus/file/audio'
require 'seamus/file/text'
require 'seamus/file/image'
require 'seamus/file/application'
require 'seamus/builder'
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
    def has_file(attribute)
      self.class_eval(%Q(
        def #{attribute.to_s}=(file)
          @#{attribute.to_s} = Seamus::Builder.new(file)
        end
        
        def #{attribute.to_s}
          @#{attribute.to_s}
        end
      ))
    end
  end

  module InstanceMethods

  end



  def self.included(receiver)
    receiver.extend         ClassMethods
    receiver.send :include, InstanceMethods
  end

end



class ThumbnailError < Exception
  
end