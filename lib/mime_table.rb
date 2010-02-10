# This module is intended to be a lightweight substitute for the
# ActionPack Mime::Type module provided with Rails. 
# It should be used for mime type lookups only and is not
# a full replacement for Mime::Type.

class MimeTable
    
    class << self
      
      @@types = []
      
      def register(content_type, extension)
        @@types << {:content_type => content_type, :extension => extension}
      end
      
      def lookup_by_extension(ext)
        ext = ext.gsub(/^\./, "").to_sym if ext.is_a?(String)
        MimeType.new(@@types.select {|t| t[:extension] == ext }.first)
      end
      
    end
    
    class MimeType
      attr_reader :content_type, :extension
      
      def initialize(options)
        @content_type = options[:content_type]
        @extension = options[:extension]
      end
      
      def to_s
        @content_type.to_s
      end
      
    end

end

MimeTable.register "application/flash", :fla
MimeTable.register "application/illustrator", :ai
MimeTable.register "application/msword", :doc
MimeTable.register "application/octet-stream", :bin
MimeTable.register "application/pdf", :pdf
MimeTable.register "application/postscript", :ps
MimeTable.register "application/rtf", :rtf
MimeTable.register "application/vnd.ms-excel", :xls
MimeTable.register "application/vnd.ms-powerpoint", :pps
MimeTable.register "application/x-bittorrent", :torrent
MimeTable.register "application/x-compress", :z
MimeTable.register "application/x-compressed", :tgz
MimeTable.register "application/x-dvi", :dvi
MimeTable.register "application/x-gzip", :gz
MimeTable.register "application/x-photoshop", :psd
MimeTable.register "application/x-shockwave-flash", :swf
MimeTable.register "application/x-stuffit", :sit
MimeTable.register "application/x-tar", :tar
MimeTable.register "application/zip", :zip
MimeTable.register "audio/aiff", :aif
MimeTable.register "audio/basic", :snd
MimeTable.register "audio/it", :it
MimeTable.register "audio/mp4", :f4a
MimeTable.register "audio/mpeg", :mp2
MimeTable.register "audio/mpeg", :mp3
MimeTable.register "audio/ogg", :ogg
MimeTable.register "audio/wav", :wav
MimeTable.register "audio/x-jam", :jam
MimeTable.register "audio/x-m4a", :m4a
MimeTable.register "audio/x-midi", :mid
MimeTable.register "audio/x-mpegurl", :m3u
MimeTable.register "audio/x-ms-wma", :wma
MimeTable.register "image/bmp", :bmp
MimeTable.register "image/cineon", :cin
MimeTable.register "image/dpx", :dpx
MimeTable.register "image/gif", :gif
MimeTable.register "image/jpeg", :jpg
MimeTable.register "image/pict", :pic
MimeTable.register "image/png", :png
MimeTable.register "image/svg+xml", :svg
MimeTable.register "image/tiff", :tif
MimeTable.register "image/vnd.dxf", :dxf
MimeTable.register "image/x-pcx", :pcx
MimeTable.register "image/x-pict", :pct
MimeTable.register "image/x-quicktime", :qif
MimeTable.register "text/UTF-8", :txt
MimeTable.register "text/x-java-source", :jav
MimeTable.register "text/x-script.python", :py
MimeTable.register "text/x-script.sh", :sh
MimeTable.register "text/x-ruby", :rb
MimeTable.register "video/mp4", :f4v
MimeTable.register "video/mp4", :mp4
MimeTable.register "video/quicktime", :mov
MimeTable.register "video/x-dv", :dv
MimeTable.register "video/x-flv", :flv
MimeTable.register "video/x-m4v", :m4v
MimeTable.register "video/x-motion-jpeg", :mjpg
MimeTable.register "video/x-mpeg", :mpg
MimeTable.register "video/x-ms-asf", :asf
MimeTable.register "video/x-ms-wmv", :wmv
MimeTable.register "video/x-msvideo", :avi
MimeTable.register "video/x-sgi-movie", :mv
MimeTable.register "vmd-rn-realmedia", :rm
MimeTable.register "vnd.microsoft.icon", :ico
MimeTable.register "vnd.rn-realaudio", :ra
MimeTable.register "vnd.rn-realmedia-vbr", :rmvb
# MimeTable::Type.register_alias "application/postscript", :eps
# MimeTable::Type.register_alias "application/vnd.ms-excel", :xla
# MimeTable::Type.register_alias "application/vnd.ms-excel", :xlb
# MimeTable::Type.register_alias "application/vnd.ms-excel", :xld
# MimeTable::Type.register_alias "application/vnd.ms-excel", :xlk
# MimeTable::Type.register_alias "application/vnd.ms-excel", :xll
# MimeTable::Type.register_alias "application/vnd.ms-excel", :xlm
# MimeTable::Type.register_alias "application/vnd.ms-excel", :xlt
# MimeTable::Type.register_alias "application/vnd.ms-excel", :xlv
# MimeTable::Type.register_alias "application/vnd.ms-excel", :xlw
# MimeTable::Type.register_alias "application/vnd.ms-powerpoint", :ppt
# MimeTable::Type.register_alias "application/x-gzip", :gzip
# MimeTable::Type.register_alias "audio/aiff", :aifc
# MimeTable::Type.register_alias "audio/aiff", :aiff
# MimeTable::Type.register_alias "audio/ogg", :oga
# MimeTable::Type.register_alias "audio/ogg", :ogv
# MimeTable::Type.register_alias "audio/ogg", :ogx
# MimeTable::Type.register_alias "audio/ogg", :spx
# MimeTable::Type.register_alias "audio/x-midi", :midi
# MimeTable::Type.register_alias "image/jpeg", :jfif
# MimeTable::Type.register_alias "image/jpeg", :jpeg
# MimeTable::Type.register_alias "image/pict", :pict
# MimeTable::Type.register_alias "image/tiff", :tiff
# MimeTable::Type.register_alias "text/plain", :log
# MimeTable::Type.register_alias "text/x-java-source", :java
# MimeTable::Type.register_alias "video/mpeg", :m1v
# MimeTable::Type.register_alias "video/mpeg", :m2a
# MimeTable::Type.register_alias "video/mpeg", :m2v
# MimeTable::Type.register_alias "video/quicktime", :qt
# MimeTable::Type.register_alias "video/x-mpeg", :mpeg
# MimeTable::Type.register_alias "video/x-ms-asf", :asx
