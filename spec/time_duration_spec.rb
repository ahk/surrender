require 'lib/time_duration.rb'

describe TimeDuration do
  before :each do
    @duration = TimeDuration.new 300
  end

  it "should record duration in integers" do
    @duration.seconds.should be_instance_of Fixnum
  end
  
  it "knows how to parse hours into seconds" do
    example  = "2 hours"
    time_obj = TimeDuration.parse_duration example
    time_obj.seconds.should be_instance_of Fixnum
  end
  
  it "knows how to parse minutes into seconds" do
    example  = "5 minutes"
    time_obj = TimeDuration.parse_duration example
    time_obj.seconds.should be_instance_of Fixnum
  end
  
  it "knows how to parse seconds into seconds" do
    example  = "30 seconds"
    time_obj = TimeDuration.parse_duration example
    time_obj.seconds.should be_instance_of Fixnum
  end
end