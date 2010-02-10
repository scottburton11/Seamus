module Seamus
  
  module Builder
    extend self
    def new(file)
      path = file.is_a?(File) ? Pathname.new(file.path) : Pathname.new(file)
      type = file_type(path.extname)
      extension = path.extname.gsub('.', '')
      build_class(type, extension).new(path.to_s)
    end

    def file_type(extension)
      determine_type_from_extension(extension)
    end

    private

    def build_class(type, extension)
      Seamus::File.module_eval %Q{
        class #{extension.capitalize} < #{type}; end
      } unless Seamus::File.const_defined?("#{extension.capitalize}")
      Seamus::File.const_get("#{extension.capitalize}")
    end

    def determine_type_from_extension(extension)
      begin
        Mime::Type.lookup_by_extension(extension).to_s.split("/").first.capitalize
      rescue NoMethodError
        "Application"
      rescue NameError
        if MimeTable
          MimeTable.lookup_by_extension(extension).to_s.split("/").first.capitalize
        else
          raise LoadError, "Mime module not loaded"
        end
      end
    end
    # 
    # # returns the last segment of the filename, eg "foo.mov".extension => ".mov"
    # def extension
    #   file_name.split('.').last.downcase
    # end
    
  end
end