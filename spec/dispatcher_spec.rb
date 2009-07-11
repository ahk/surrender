require File.dirname(__FILE__) + '/spec_helper'

describe Surrender::Dispatcher do
  before(:each) do
    @dispatcher = Surrender::Dispatcher.new
    @a_msg = "eggs in 5 minutes"
  end
  
  it "should be able to list all of its running tasks" do
    @dispatcher.should respond_to(:tasks)
    @dispatcher.should have(2).tasks
  end
  
  it "should define a main awareness task" do
    task = Surrender::Task.new "never", "never", "10 minutes", "wake up!"
    @dispatcher.tasks.should include(task)
  end
  
  it "should define a break task" do
    task = Surrender::Task.new "never", "never", "29 minutes", "BREAK: Rest the eyes!"
    @dispatcher.tasks.should include(task)
  end
  
  it "should delegate send_message to Output.send_notification" do
    Surrender::Output.should_receive(:send_notification).with(@a_msg).and_return(true)
    @dispatcher.send_message @a_msg
  end
  
  it "should be able to identify which messages are ripe for harvesting" do
    ripe_messages = ["eggs done!", "break time"]
    @dispatcher.harvest_messages.should have(ripe_messages)
  end
  
  it "should track messages concurrently, rather than serially" do
    violated "Incomplete, needs refactor"
  end
end