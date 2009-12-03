require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe Numeric do
  describe "evenize" do
    it "rounds an odd number up to the nearest even number" do
      127.evenize.should eql(128)
    end
    
    it "rounds an odd number down to the nearest even number" do
      127.evenize("-").should eql(126)
    end
  end
  
  describe "oddize" do
    it "rounds an even number up to the nearest odd number" do
      256.oddize.should eql(257)
    end
    
    it "rounds an even number down to the nearest odd number" do
      256.oddize("-").should eql(255)
    end
  end
end