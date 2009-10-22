require File.dirname(__FILE__) + '/spec_helper'

describe Surrender::Message::Reminder do
  before(:each) do
    @reminder = Surrender::Message::Reminder
    @duration = Surrender::TimeDuration.parse("10 minutes").seconds
  end
  
  it "can create multiple messages from a Hash" do
    hash = {
      :msg_1 => {
        'seconds_to_next_message' => 5,
        'time_to_display_at'      => sooner_time,
        'text'                    => 'message 1'
      },
      :msg_2 => {
        'seconds_to_next_message' => 5,
        'time_to_display_at'      => later_time,
        'text'                    => 'message 2'
      }
    }
    messages = Surrender::Message.load_hash hash
    
    messages.should have(2).items
    messages.each do |msg|
      msg.should be_instance_of Surrender::Message::Reminder
    end
  end
  
  it "can compare by attributes using ==" do
    msg1 = @reminder.new "msg", @duration
    msg2 = msg1.clone
    msg1.should == msg2
  end
  
  it "creates new messages of its type to add to a Task message queue" do
    first_msg = @reminder.new "msg", @duration
    next_time = first_msg.time_to_display_at + first_msg.seconds_to_next_message
    next_msg =  @reminder.new "msg", @duration, next_time
    
    first_msg.next_message.should == next_msg
  end
  
  it "knows if it is ripe enough to display" do
    msg = @reminder.new 'msg', @duration, Time.now
    msg.is_ripe?.should == true
  end
end