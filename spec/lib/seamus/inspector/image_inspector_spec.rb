require File.expand_path(File.dirname(__FILE__)) + "/../../../spec_helper.rb"

describe Seamus::ImageInspector do
  before(:each) do
    @image = mock(Seamus::File::Image, :path => "/path/to/image.jpg")
    @image.extend Seamus::ImageInspector
  end
  
  it "loads an image inspector using Devil.load_image" do
    Devil.should_receive(:load_image).with("/path/to/image.jpg")
    @image.inspector
  end
end