require 'digest/md5'
require 'open3'
require 'tempfile'

$LOAD_PATH << File.join(File.dirname(File.expand_path(__FILE__)), "lib")

require 'core/numeric'
require 'seamus/standard_additions'
require 'seamus/inspector/video_inspector'
require 'seamus/inspector/audio_inspector'
require 'seamus/inspector/image_inspector'
require 'seamus/inspector/application_inspector'
require 'seamus/inspector/text_inspector'
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
# 
# Seamus inspects your file and discovers useful attributes. It is at its best with rich 
# digital media - video, audio and image files - but is suitable for use with any file type.
# Just provide a path to Seamus::Builder.new for an enhanced File object that knows about your
# file. 
# 
#   movie = Seamus::Builder.new("/path/to/my/movie.mov")
#   
#   movie.width
#   # => 720
#   
#   movie.video_codec
#   # => 'h264'
# 
# Or if you prefer, include Seamus in a class and use the has_file :file_attribute class 
# method for attachments.
#   
#   class Upload
#     include Seamus
#     has_file :file
#   end
#   
#   u = Upload.new
#   u.file = "/path/to/image.jpg"
#   u.file.width
#   # => 3284
#   
# Seamus supports thumbnail creation for visual media types. The #thumbnail method returns
# an IO instance.
# 
#   u.file.thumbnail
#   # => #<IO:0x357898>
#   

module Seamus

  module ClassMethods
  
    # Creates an accessor for a Seamus-enabled file. has_file :upload would create
    # an #upload method and a #upload= method.
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