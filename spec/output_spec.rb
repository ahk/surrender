require File.dirname(__FILE__) + '/spec_helper'

describe Surrender::Output do
  it "should add double quotes for growlnotify" do
    Surrender::Output.double_quote("what").should == "\"what\""
  end
  
  it "should use different output methods for different platforms"
  
  it "should support desktop notifications across supported platforms and windowing sytems" do
    pending "platform identification Linux, Windows"
  end
end