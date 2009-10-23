require File.dirname(__FILE__) + '/spec_helper'

describe Surrender::Task do
  before :each do
    @task = Surrender::Task.new sooner_time, later_time, 'text'
    @ripe_msg  = Surrender::Message::Reminder.new("reminder", 600)
    @ripe_msg.ticks = 600 # ripen the message
  end
  
  it "creates multiple tasks from YAML" do
    tasks = Surrender::Task.load_yaml <<-YAML
    task_1:
      start_time: #{sooner_time}
      end_time:   #{later_time}
      text:       This is task 1
    task_2:
      start_time: #{sooner_time}
      end_time:   #{later_time}
      text:       This is task 2
    YAML

    tasks.should have(2).items
    tasks.each do |task|
     task.should be_instance_of Surrender::Task
     task.start_time.should == sooner_time
     task.end_time.should == later_time
    end
  end
  
  it "adds messages to YAML loaded tasks" do
    yaml = <<-YAML
    task:
      start_time: #{sooner_time}
      end_time:   #{later_time}
      text:       This is a task
      messages:
        msg_1:
          seconds_to_next_message: 5
          time_to_display_at:      #{sooner_time}
          text:                    message 1
        msg_2:
          seconds_to_next_message: 5
          time_to_display_at:      #{later_time}
          text:                    message 2
    YAML
    task = Surrender::Task.load_yaml(yaml).first
    task.should have(2).messages
  end
  
  it "should tick" do
    @task.should respond_to(:tick!)
  end
  
  it "should tick all messages on tick" do
    @task.add_message @ripe_msg
    @ripe_msg.should_receive :tick!
    @task.tick!
  end
  
  it "should be able to add new messages to the queue" do
    @task.add_message @ripe_msg
    @task.message_queue.should include @ripe_msg
  end
  
  it "should know if it has ripe messages" do
    @task.add_message @ripe_msg
    @task.ripe?.should == true
  end
  
  it "should be able to return multiple ripe messages" do
    msg1 = @ripe_msg.clone
    msg2 = @ripe_msg.clone
    @task.add_message msg1
    @task.add_message msg2
    
    @task.pick_ripe_messages!.should include(msg1,msg2)
  end
  
  it "should raise an exception when picking a message from an empty queue" do
    lambda {@task.pick_ripe_messages!}.should raise_error Surrender::Task::MessageQueueEmpty
  end
  
  it "should delete the ripest message after it is picked" do
    @task.add_message @ripe_msg
    @task.pick_ripe_messages!
    @task.message_queue.should_not include(@ripe_msg)
  end
  
  it "should return task after adding messages" do
    exp = @task.add_message @ripe_msg
    exp.should be_instance_of Surrender::Task
  end
end
