# surrender libs
lib_dir = File.dirname(__FILE__)
%w{task time_duration growl_message input message output dispatcher default_tasks}.each do |lib|
  require File.join lib_dir, lib
end