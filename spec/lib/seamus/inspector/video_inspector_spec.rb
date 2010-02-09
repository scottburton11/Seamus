require File.expand_path(File.dirname(__FILE__)) + "/../../../spec_helper.rb"

describe Seamus::VideoInspector do
  
  include FakeFS::SpecHelpers
  
  before(:each) do
    File.new("/path/to/movie.mov", "w+") {|file| file << "MovieData"}
    file = File.open("/path/to/movie.mov", "r")
    @sfile = file.dup.extend Seamus::VideoInspector
  end

  describe "loading inspection attributes" do

    it "calls #inspection_attributes" do
      @sfile.should_receive(:inspection_attributes).and_return({:one => "one", :two => "two"})
      @sfile.file_attributes.should == {:one => "one", :two => "two"}
    end

  end

  describe "RVideo inspection" do
    it "creates a new RVideo inspector object using the raw_response" do
      @sfile.should_receive(:raw_response).and_return("FFmpeg Raw Response Data")
      RVideo::Inspector.should_receive(:new).with(:raw_response => "FFmpeg Raw Response Data")
      @sfile.send(:media_stat)
    end
  end
  
  describe "FFmpeg raw_response" do
    it "reads stderr IO data returned by Open3" do
      @stdin, @stdout, @stderr = mock(IO), mock(IO), mock(IO, :read => "Standard Error Output")
      Open3.should_receive(:popen3).
            with("ffmpeg -i '/path/to/movie.mov' -").
            and_return([@stdin, @stdout, @stderr])
      @sfile.send(:raw_response).should eql(@stderr.read)
    end
  end
  
end