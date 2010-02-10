require File.expand_path(File.dirname(__FILE__)) + "/../../../spec_helper.rb"

describe Seamus::VideoInspector do
  before(:each) do
    @video = mock(Seamus::File::Video, :path => "/path/to/video.jpg")
    @video.extend Seamus::VideoInspector
  end
  
  it "loads an video inspector using RVideo::Inspector" do
    RVideo::Inspector.should_receive(:new).with(:file => "/path/to/video.jpg")
    @video.inspector
  end
end