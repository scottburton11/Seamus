module Seamus
  module StandardAdditions
    
    # Returns a Digest::MD5 instance
    def md5
      @md5 ||= Digest::MD5.file(self.path)
    end

    def md5_digest
      md5.digest
    end

    def md5_base64_encoded
      Base64.encode64(md5_digest).strip
    end
    
    def size
      stat.size
    end
    
    def content_type
       MimeTable.lookup_by_extension(extension).to_s
    end
    
    def add_inspection_attributes(*args)
      args.select{|arg| arg.respond_to?(:to_sym) }.each do |arg|
        inspection_attributes.push arg
      end
    end

    def [](attribute)
      attributes[attribute.to_sym]
    end

    def attributes
      @attributes ||= inspection_attributes.inject({}) do |h, i|
        h[i] = self.send(i) if self.respond_to?(i)
        h
      end
    end

    private
    
    def create_method(method, method_binding)
      self.class.send(:define_method, method.to_sym, method_binding)
    end

    def create_methods_for(object, options={})
      options[:except] = [options[:except]] unless options[:except].is_a?(Array)
      object.public_methods(false).each do |method|
        create_method(method, lambda {object.method(method.to_s).call}) unless options[:except].include?(method)
      end
    end
    
    def standard_attributes
      [:size, :md5]
    end

    # def method_missing(method, *args, &block)
    #   if file_attributes.has_key?(method.to_s)
    #     file_attributes[method.to_s]
    #   else
    #     super(method, *args, &block)
    #   end
    # end
  end
end