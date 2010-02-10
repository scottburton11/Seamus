module Factories
  def mov
    File.open(File.expand_path(File.dirname(__FILE__) + "/fixtures/test.mov"))
  end
  
  def mp4
    File.open(File.expand_path(File.dirname(__FILE__) + "/fixtures/test.mp4"))
  end
  
  def jpg
    File.open(File.expand_path(File.dirname(__FILE__) + "/fixtures/test.jpg"))
  end
end