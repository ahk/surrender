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
  
  it "should be able to add new messages to the queue" do
    @task.add_message @msg
    @task.message_queue.should include @msg
  end
  
  it "should know if it has ripe messages" do
    @task.add_message @msg
    @task.send(:has_a_ripe_message?).should == true
  end
  
  it "should be able to return multiple ripe messages" do
    now = Time.now
    msg1 = Surrender::Message::Reminder.new(600, now)
    msg2 = Surrender::Message::Reminder.new(800, now)
    @task.add_message msg1
    @task.add_message msg2

    @task.pick_ripe_messages!.should include(msg1,msg2)
  end
  
  it "should raise an exception when picking a message from an empty queue" do
    lambda {@task.pick_ripe_messages!}.should raise_error Surrender::Task::MessageQueueEmpty
  end
  
  it "should delete the ripest message after it is picked" do
    @task.add_message @msg
    @task.pick_ripe_messages!
    @task.message_queue.should_not include(@msg)
  end
end
