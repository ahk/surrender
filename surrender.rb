#!/usr/bin/env ruby

# This script should be run while working at a computer, 
# and is intended to increase the level of self awareness in a person's day 
# while augmenting their level of focus.
# Requires: growlnotify (Mac notifier)

require 'rubygems'
require 'daemons'

# fire up the dispatcher as a daemon
root = File.dirname(__FILE__)
lib_dir = root + '/lib'
example_dir = root + '/examples'
task_file = IO.read(example_dir + '/default_tasks.yml')

require File.join lib_dir, 'surrender'

Daemons.run_proc 'surrender.rb' do
  dispatcher = Surrender::Dispatcher.new
  dispatcher.load_tasks task_file
  dispatcher.main_loop
end