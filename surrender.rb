require 'rubygems'
require 'daemons'

# surrender libs
require 'lib/input'
require 'lib/growl_message'
require 'lib/output'
require 'lib/task'

proc_file = File.join File.dirname(__FILE__), 'lib', 'dispatcher.rb'
Daemons.run proc_file