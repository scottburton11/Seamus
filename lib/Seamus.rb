require 'rvideo'
require 'digest/md5'
$LOAD_PATH << './lib'

require 'inspector/video_inspector'
require 'inspector/audio_inspector'
require 'inspector/application_inspector'
require 'mime_table'

module Seamus
  
  module ClassMethods
    
  end
  
  module InstanceMethods

    attr_accessor :file_attributes, :file_path

    def attributes_for(file_path)
      @file_path = file_path
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
    
    def inspect_file
      @file_attributes = {}
      begin
        inspector = Seamus.const_get("#{file_type.classify}Inspector").new(file_path)
	      @file_attributes.merge!(inspector.stats)
	      logger.info("File stats:\n#{pp inspector.stats}")
      rescue NameError => e
        logger.info("No inspector for type: #{file_type} - the error was: #{e}")
      rescue => e
        logger.warn("An error ocurred while inspecting the file: #{e}")
      end
      return @file_attributes
    end

    protected
    
    def logger
      @logger ||= Logger.new(STDOUT) unless defined? @logger
    end
    
    private
    
    def file_name
      File.basename(file_path)
    end
    
    def file_type
      begin
        file_attributes["content-type"].split("/").first
      rescue
        determine_type_from_extension
      end
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
    
    
  end
  

  def self.included(receiver)
    receiver.extend         ClassMethods
    receiver.send :include, InstanceMethods
  end
    
end