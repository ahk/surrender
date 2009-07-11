require File.dirname(__FILE__) + '/spec_helper'

describe Surrender::Task do
  before :each do
    @task = Surrender::Task.new
  end

  it "carries a reminder frequency TimeDuration" do
    @task.reminder_frequency.should be_instance_of Surrender::TimeDuration
  end
  
  it "can parse strings into TimeDuration" do
    example = "5 minutes"
    # FIXME is this the best way to test private methods? Should I even be doing so?
    time_obj = @task.send :parse_reminder_frequency, example
    time_obj.should be_instance_of Surrender::TimeDuration
  end
end
