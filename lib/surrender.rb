# surrender libs
lib_dir = File.dirname(__FILE__)
%w{dispatcher growl_message input message output task time_duration}.each do |lib|
  require File.join lib_dir, lib
end