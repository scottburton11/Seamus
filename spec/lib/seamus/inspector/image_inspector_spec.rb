require File.expand_path(File.dirname(__FILE__)) + "/../../../spec_helper.rb"

describe Seamus::ImageInspector do

  include FakeFS::SpecHelpers
  
  before(:each) do
    # FileUtils.touch("./image.jpg")
    # @seamus_image = Seamus::ImageInspector.new("./image.jpg")
    img = File.new("/path/to/img.jpg", "w+") {|file| file << "Image Data"}
    @seamus_image = img.dup.extend Seamus::ImageInspector
  end

  it "loads inspected attributes" do
    @seamus_image.should_receive(:inspection_attributes).
                  and_return({:width => 100, :height => 100})
    @seamus_image.file_attributes.should == {:width => 100, :height => 100}
  end
  
  # it "responds to #stats" do
  #   @seamus_image.should respond_to(:stats)
  # end
  # 
  describe "attribute assignment" do
    
    before(:each) do
      @image = mock(Devil::Image, :width => 100, :height => 100)
      @seamus_image.should_receive(:image).any_number_of_times.and_return(@image)
      @seamus_image.should_receive(:size).and_return(100)
    end
    
    it "returns a hash" do
      @seamus_image.file_attributes.should be_an_instance_of(Hash)
    end
    
    it "assigns :width" do
      @seamus_image.file_attributes["width"].should eql(100)
    end
    
    it "assigns :height" do
      @seamus_image.file_attributes["height"].should eql(100)
    end
    
    it "assigns :size" do
      @seamus_image.file_attributes["size"].should eql(100)
    end
    
  end
  
end