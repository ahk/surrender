require File.dirname(__FILE__) + '/spec_helper'

describe Surrender::Dispatcher do
  before(:each) do
    @a_msg = mock('Surrender::Message')
    @a_task = Surrender::Task.new
    @dispatcher = Surrender::Dispatcher.new
  end
  
  it "should be able to list all of its running tasks" do
    @dispatcher.should respond_to(:tasks)
    @dispatcher.should have(2).tasks
  end
  
  it "should be able to add new tasks" do
    @dispatcher.add_task @a_task
    @dispatcher.tasks.should include(@a_task)
  end
  
  it "should define a main awareness task" do
    task = Surrender::Dispatcher::AWARENESS_TASK
    @dispatcher.tasks.should include(task)
  end
  
  it "should define a break task" do
    task = Surrender::Dispatcher::BREAK_TASK
    @dispatcher.tasks.should include(task)
  end
  
  it "should delegate send_message to Output.send_notification" do
    Surrender::Output.should_receive(:send_notification).with(@a_msg).and_return(true)
    @dispatcher.send_message @a_msg
  end
  
  it "should be able to identify which messages are ripe for harvesting" do
    pending "Task should know if it has ripe messages" do
      @task.stub!(:pick_ripest_message!).and_return(@a_msg)
      @dispatcher.harvest_messages.should have(@a_msg)
    end
  end
  
  it "should track messages concurrently, rather than serially"
end