require File.expand_path(File.dirname(__FILE__)) + "/../../../spec_helper.rb"

describe Seamus::VideoInspector do
  
  include FakeFS::SpecHelpers
  
  before(:each) do
    File.new("/path/to/movie.mov", "w+") {|file| file << "MovieData"}
  end

  describe "loading inspection attributes" do
    before(:each) do
      file = File.open("/path/to/movie.mov", "r")
      @sfile = file.dup.extend Seamus::VideoInspector
    end
    
    it "calls #inspection_attributes" do
      @sfile.should_receive(:inspection_attributes).and_return({:one => "one", :two => "two"})
      @sfile.file_attributes.should == {:one => "one", :two => "two"}
    end
  end
  
end