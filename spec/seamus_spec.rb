require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe Seamus do

  include FakeFS::SpecHelpers
  
  before(:each) do
    #set up an in-memory file
    File.new("/path/to/movie.mov", "w+") {|file| file << "MovieData"}
  end
  
  describe Seamus::File, "core functionality" do
    before(:each) do
      @file = File.new("/path/to/movie.mov", "r")
      @sfile = Seamus::File.new(@file)
    end
    
    describe "md5 hashcode calculation" do
      it "creates a md5 instance" do
        Digest::MD5.should_receive(:file).
                    with(@sfile.path).
                    and_return("Digest_MD5_instance")
        @sfile.md5.should eql("Digest_MD5_instance")
      end
      
      it "Base64 encodes a md5 hex string" do
        @sfile.stub!(:md5_digest).
               and_return("md5-hexdigest-string")
               
        Base64.should_receive(:encode64).
               with("md5-hexdigest-string").
               and_return("base64-encoded")
        @sfile.md5_base64_encoded.should eql("base64-encoded")
      end
      
    end
    
    describe "stat convenience methods" do
      before(:each) do
        @file = File.new("/path/to/movie.mov", "r")
        @sfile = Seamus::File.new(@file)
        @stat = mock(File::Stat, :size => 1000)
        @sfile.should_receive(:stat).and_return(@stat)
      end
      
      it "gets :size from the stat object" do
        @sfile.size.should eql(1000)
      end
    end
    
    describe "dynamic methods via method_missing" do
      before(:each) do
        @file = File.new("/path/to/movie.mov", "r")
        @sfile = Seamus::File.new(@file)
        @sfile.should_receive(:file_attributes).
               any_number_of_times.
               and_return({
                 "one" => "one", 
                 "two" => "two"
               })
      end
      
      it "calls methods on the file_attributes hash first" do
        @sfile.one.should eql("one")
      end
      
      it "sends unrelated method calls up to super" do
        lambda {@sfile.three}.should raise_error(NoMethodError)
      end
      
    end
    
    it "doesn't clobber the old instance" do
      @sfile.should_not be(@file)
    end
  end
  
end
