module Seamus
  class TextInspector < Inspector
    
    def stats
      inspection_attributes
    end

    private

    def inspection_attributes
      attr_hash = {"size" => file_stat.size}
      return attr_hash
    end

  end
end