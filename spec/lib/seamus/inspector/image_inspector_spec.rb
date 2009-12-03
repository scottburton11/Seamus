require File.expand_path(File.dirname(__FILE__)) + "/../../../spec_helper.rb"

describe Seamus::ImageInspector do

  include FakeFS::SpecHelpers
  
  before(:each) do
    FileUtils.touch("./image.jpg")
    @inspector = Seamus::ImageInspector.new("./image.jpg")
  end
  
  it "responds to #stats" do
    @inspector.should respond_to(:stats)
  end
  
  describe "stats" do
    
    before(:each) do
      @image = mock(Devil::Image, :width => 100, :height => 100)
      @file_stat = mock(File::Stat, :size => 100)
      @inspector.should_receive(:image).any_number_of_times.and_return(@image)
      @inspector.should_receive(:file_stat).and_return(@file_stat)
    end
    
    it "returns a hash" do
      @inspector.stats.should be_an_instance_of(Hash)
    end
    
    it "assigns :width" do
      @inspector.stats["width"].should eql(100)
    end
    
    it "assigns :height" do
      @inspector.stats["height"].should eql(100)
    end
    
    it "assigns :size" do
      @inspector.stats["size"].should eql(100)
    end
    
  end
  
end