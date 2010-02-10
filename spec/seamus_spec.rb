require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe Seamus::Builder do
  
  describe "md5 hashcode calculation" do
    
    before(:each) do
      @movie = Seamus::Builder.new(Factories::mov.path)
    end
    
    it "creates a md5 instance" do
      Digest::MD5.should_receive(:file).
                  with(@movie.path).
                  and_return("Digest_MD5_instance")
      @movie.md5.should eql("Digest_MD5_instance")
    end

    it "Base64 encodes a md5 hex string" do
      @movie.stub!(:md5_digest).
             and_return("md5-hexdigest-string")
         
      Base64.should_receive(:encode64).
             with("md5-hexdigest-string").
             and_return("base64-encoded")
      @movie.md5_base64_encoded.should eql("base64-encoded")
    end
  end
  
  describe "on-demand classes" do
    it "creates a ::Mov class for .mov files" do
      @movie = Seamus::Builder.new(Factories::mov.path)      
      @movie.should be_an_instance_of(Seamus::File::Mov)
    end
    
    it "creates a ::Mp4 class for .mp4 files" do
      @mpeg4 = Seamus::Builder.new(Factories::mp4.path)
      @mpeg4.should be_an_instance_of(Seamus::File::Mp4)
    end
    
    it "creates a ::Jpg class for .jpg files" do
      @image = Seamus::Builder.new(Factories::jpg.path)  
      @image.should be_an_instance_of(Seamus::File::Jpg)
    end
    
    it "includes Seamus::File::Video into Mov" do
      Seamus::File::Mov.superclass.should be(Seamus::File::Video)
    end
    
    #etc
    
  end
  
end