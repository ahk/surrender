require File.dirname(__FILE__) + '/spec_helper'

describe Surrender::Message::Reminder do
  before(:each) do
    @reminder = Surrender::Message::Reminder
    @duration = Surrender::TimeDuration.parse("10 minutes").seconds
  end
  
  it "instantiates with a TimeDuration to create the next message" do
    msg = @reminder.new @duration
    msg.seconds_to_next_message.should == @duration
  end
  
  it "can compare by attributes using ==" do
    now = Time.now
    msg1 = @reminder.new @duration, now
    msg2 = @reminder.new @duration, now
    msg1.should == msg2
  end
  
  it "create new messages of its type to add to a Task message queue" do
    first_msg = @reminder.new @duration
    
    next_time = first_msg.time_to_display_at + first_msg.seconds_to_next_message
    next_msg =  @reminder.new( @duration, next_time )
    
    first_msg.next_message.should == next_msg
  end
end