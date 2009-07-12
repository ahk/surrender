# surrender libs
lib_dir = File.dirname(__FILE__)
%w{input growl_message output task time_duration dispatcher message}.each do |lib|
  require File.join lib_dir, lib
end