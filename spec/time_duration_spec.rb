require File.dirname(__FILE__) + '/spec_helper'

describe Surrender::TimeDuration do
  before :each do
    @duration = Surrender::TimeDuration.new 300
  end

  it "should record duration in integers" do
    @duration.seconds.should be_instance_of Fixnum
  end
  
  it "won't parse integers" do
    got = Surrender::TimeDuration.parse @duration.seconds
    got.should == Surrender::TimeDuration.new(300)
  end
  
  it "knows how to parse hours into seconds" do
    example  = "2 hours"
    time_obj = Surrender::TimeDuration.parse example
    time_obj.seconds.should be_instance_of Fixnum
    time_obj.seconds.should eql 7200
  end
  
  it "knows how to parse minutes into seconds" do
    example  = "10 minutes"
    time_obj = Surrender::TimeDuration.parse example
    time_obj.seconds.should be_instance_of Fixnum
    time_obj.seconds.should eql 600
  end
  
  it "knows how to parse seconds into seconds" do
    example  = "30 seconds"
    time_obj = Surrender::TimeDuration.parse example
    time_obj.seconds.should be_instance_of Fixnum
    time_obj.seconds.should eql 30
  end
end