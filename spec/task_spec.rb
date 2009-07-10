require File.dirname(__FILE__) + '/spec_helper'
require 'lib/task'
require 'lib/time_duration'

describe Task do
  before :each do
    @task = Task.new
  end

  it "carries a reminder frequency TimeDuration" do
    @task.reminder_frequency.should be_instance_of TimeDuration
  end
  
  it "can parse strings into TimeDuration" do
    example = "5 minutes"
    time_obj = Task.parse_reminder_frequency example
    time_obj.should be_instance_of TimeDuration
  end
end
