require File.dirname(__FILE__) + '/spec_helper'

describe Surrender::Dispatcher do
  before(:each) do
    @msg = Surrender::Message::Reminder.new "reminder", 600, Time.now
    @task = Surrender::Task.new
    @dispatcher = Surrender::Dispatcher.new
  end
  
  it "should be able to list all of its running tasks" do
    @dispatcher.should respond_to(:tasks)
    2.times {@dispatcher.tasks << @task}
    @dispatcher.should have(2).tasks
  end
  
  it "should be able to add new tasks" do
    @dispatcher.add_task @task
    @dispatcher.tasks.should include(@task)
  end
  
  it "should delegate send_message to Output.send_notification" do
    Surrender::Output.should_receive(:send_notification).with(@msg).and_return(true)
    @dispatcher.send_message @msg
  end
  
  it "should be able to identify which messages are ripe for harvesting" do
    @dispatcher.add_task @task
    @task.message_queue << @msg
    @dispatcher.harvest_messages.should include(@msg)
  end
  
  it "should be able to harvest multiple ripe messages from a single task" do
    @dispatcher.add_task @task
    new_msg = proc {Surrender::Message::Reminder.new "text", 600, Time.now}
    msg1 = new_msg.call
    msg2 = new_msg.call
    
    @task.add_message msg1
    @task.add_message msg2
    @dispatcher.harvest_messages.should include(msg1, msg2)
  end
  
  it "should send a startup message" do
    @dispatcher.startup_message.should be_instance_of Surrender::Message::Warning
  end
end