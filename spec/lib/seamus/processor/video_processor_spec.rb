require File.expand_path(File.dirname(__FILE__)) + "/../../../spec_helper.rb"

describe Seamus::VideoProcessor do
  # include FakeFS::SpecHelpers
  
  before(:each) do
    # File.new("/path/to/movie.mov", "w+") {|file| file << "MovieData"}
    # file = File.open("/path/to/movie.mov", "r")
    # @video = file.dup.extend Seamus::VideoProcessor
    @video = mock(Seamus::File::Video, :path => "/path/to/movie.mov")
    @video.extend Seamus::VideoProcessor
  end
  
  describe "thumbnail creation" do
    before(:each) do
      @video.stub!(:start_time => 3333, :dimensions_string => "320x180")
    end
    
    it "uses Open3 to capture the stdout of ffmpeg in an IO instance" do
      @stdin, @stdout, @stderr = mock(IO), mock(IO), mock(IO)
      Open3.should_receive(:popen3).
            with("ffmpeg -y -ss 3333 -i '/path/to/movie.mov' -t 00:00:01 -vcodec mjpeg -vframes 1 -an -f rawvideo -s 320x180 - ").
            and_return([@stdin, @stdout, @stderr])
      @video.thumbnail.should eql(@stdout)
    end
    
  end
  
  describe "thumbnail capture start time" do
    it "defaults to 10000/3333 - roughly 3 seconds in - when the #duration attribute is nil" do
      @video.stub!(:duration => nil)
      @video.send(:start_time).should eql(10000/3333)
    end
    
    it "equals one third of the duration (in milliseconds)" do
      @video.stub!(:duration => 20000)
      @video.send(:start_time).should eql(20000/3333)
    end
  end
  
  describe "aspect ratio" do
    before(:each) do
      @video.stub!(:width => 640, :height => 480)
    end
    
    it "is a rational number calculated from #width divided by #height" do
      @video.send(:aspect_ratio).should == Rational(4,3)
    end
  end
  
  describe "dimensions string" do
    before(:each) do
      @video.stub!(:aspect_ratio => Rational(4,3))
    end
    
    it "is a formatted 'WxH' string, using the aspect ratio to calculate the height constant width" do
      @video.send(:dimensions_string).should eql("320x240")
    end
    
    it "can be provided with an alternate width" do
      @video.send(:dimensions_string, 240).should eql("240x180")
    end
    
  end
  
end