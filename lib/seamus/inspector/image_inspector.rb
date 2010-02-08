require 'devil'

module Seamus
  module ImageInspector
    def file_attributes
      @file_attributes ||= inspection_attributes
    end
    
    private
    
    def inspection_attributes
      attr_hash = {}
      ["width", "height"].each do |attribute|
        attr_hash[attribute] ||= image.send(attribute.to_sym) if image.respond_to?(attribute)
      end
      attr_hash.merge!("size" => self.size)      
      return attr_hash
    end
    
    def image
      @image ||= Devil.load_image(self.path)
    end
    
  end
end