require File.dirname(__FILE__) + '/spec_helper'

describe Surrender::Message::Reminder do
  before(:each) do
    @reminder = Surrender::Message::Reminder
    @ten_minutes = Surrender::TimeDuration.parse("10 minutes").seconds
  end
  
  it "can create multiple messages from a Hash" do
    hash = {
      :msg_1 => {
        'seconds_to_next_message' => 5,
        'text'                    => 'message 1'
      },
      :msg_2 => {
        'seconds_to_next_message' => 5,
        'text'                    => 'message 2'
      }
    }
    messages = Surrender::Message.load_hash hash
    
    messages.should have(2).items
    messages.each do |msg|
      msg.should be_instance_of Surrender::Message::Reminder
      msg.ticks_til_ripe.should be 5
    end
  end
  
  it "should start with 0 ticks" do
    msg = @reminder.new "msg", @ten_minutes
    msg.ticks.should == 0
  end
  
  it "should add a tick on tick!" do
    msg = @reminder.new "msg", @ten_minutes
    msg.tick!
    msg.ticks.should == 1
  end
  
  it "knows if it is ripe enough to display" do
    msg = @reminder.new 'msg', 5
    4.times { msg.tick! }
    msg.is_ripe?.should be false
    
    msg = @reminder.new 'msg', 5
    5.times { msg.tick! }
    msg.is_ripe?.should be true
  end
  
  it "can compare by attributes using ==" do
    msg1 = @reminder.new "msg", @ten_minutes
    msg2 = @reminder.new "msg", @ten_minutes
    msg1.should == msg2
  end
  
  it "creates new messages of its type to add to a Task message queue" do
    first_msg = @reminder.new "msg", @ten_minutes
    next_msg  = first_msg.clone
    
    5.times {first_msg.tick!}
    first_msg.next_message.should == next_msg
  end
end