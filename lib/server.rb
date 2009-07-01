require 'rubygems'
require 'daemons'

proc_file = File.join __FILE__, '..', 'dispatcher.rb'
Daemons.run proc_file