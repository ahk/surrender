require File.dirname(__FILE__) + '/spec_helper'

describe Surrender::SystemInfo do
  it "should be able to identify Mac OS X" do
    Surrender::SystemInfo.current_platform.should eql 'macosx'
  end
  
  it "should fail gracefully if growlnotify is missing" do
    Surrender::SystemInfo.stub!(:system).and_return false
    proc {Surrender::SystemInfo.check_dependencies}.should raise_error Surrender::DependencyError
  end

  it "should fail gracefully if not used on Mac" do
    # TODO: this is nasty stubbing
    Surrender::SystemInfo.stub!(:`).and_return "Linux"
    proc {Surrender::SystemInfo.check_dependencies}.should raise_error Surrender::DependencyError
  end
  
  # TODO: dumb pending
  it "should be able to identify the current windowing system"
end
