require 'rubygems'
require 'daemons'

proc_file = File.join __FILE__, '..', 'surrender.rb'
Daemons.run proc_file