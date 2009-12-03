require 'devil'

module Seamus
  class ImageInspector < Inspector
    def stats
      inspection_attributes
    end
    
    private
    
    def inspection_attributes
      attr_hash = {}
      ["width", "height"].each do |attribute|
        attr_hash[attribute] ||= image.send(attribute.to_sym) if image.respond_to?(attribute)
      end
      attr_hash.merge!("size" => file_stat.size)      
      return attr_hash
    end
    
    def image
      @image ||= Devil.load_image(file.path)
    end
    
  end
end