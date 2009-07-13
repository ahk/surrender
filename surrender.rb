#!/usr/bin/env ruby

# This script should be run while working at a computer, 
# and is intended to increase the level of self awareness in a person's day 
# while augmenting their level of focus.
# Requires: growlnotify (Mac notifier)

require 'rubygems'
require 'daemons'

# fire up the dispatcher as a daemon
lib_dir = File.dirname(__FILE__) + '/lib'
require File.join lib_dir, 'surrender'
Daemons.run_proc 'surrender.rb' do
  dispatcher = Surrender::Dispatcher.new
  dispatcher.add_task Surrender::DefaultTasks.awareness_task
  dispatcher.add_task Surrender::DefaultTasks.break_task
  dispatcher.main_loop
end