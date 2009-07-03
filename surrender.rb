require 'rubygems'
require 'daemons'

# surrender libs
lib_dir = File.join File.dirname(__FILE__), 'lib'
%w{input growl_message output task}.each do |lib|
  require File.join lib_dir, lib
end

# fire up the dispatcher as a daemon
Daemons.run File.join lib_dir, 'dispatcher.rb'