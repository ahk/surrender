#!/usr/bin/env ruby -wKU

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
  Surrender::Dispatcher.new.main_loop
end