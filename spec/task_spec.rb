require File.dirname(__FILE__) + '/spec_helper'

describe Surrender::Task do
  before :each do
    @task = Surrender::Task.new
    @msg = Surrender::Message::Reminder.new(600, Time.now)
  end

  it "carries a reminder frequency TimeDuration" do
    @task.reminder_frequency.should be_instance_of Surrender::TimeDuration
  end
  
  it "can parse strings into TimeDuration" do
    example = "5 minutes"
    time_obj = @task.send :parse_reminder_frequency, example
    time_obj.should be_instance_of Surrender::TimeDuration
  end
  
  it "should know if it has ripe messages" do
    @task.message_queue << @msg
    @task.send(:has_a_ripe_message?).should == true
  end
  
  it "should be able to return the ripest message" do
    @task.message_queue << @msg
    @task.pick_ripest_message!.should equal(@msg)
  end
  
  it "should raise an exception when picking a message from an empty queue" do
    lambda {@task.pick_ripest_message!}.should raise_error Surrender::Task::MessageQueueEmpty
  end
  
  it "should delete the ripest message after it is picked" do
    @task.message_queue << @msg
    @task.pick_ripest_message!
    @task.message_queue.should_not include(@msg)
  end
end
