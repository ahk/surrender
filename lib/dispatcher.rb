=begin
This script should be run while working at a computer, 
and is intended to increase the level of self awareness in a person's day 
while augmenting their level of focus.
Requires: growlnotify (Mac notifier)
=end

#TODO this file used to contain the ENTIRE original program, must refactor this code 
# out into the proper component libraries
require 'input'
require 'growl_message'
require 'output'
require 'task'

MESSAGES = ["Get back to work!",
            "Are you awake?",
            "Try some coffee if you haven't already.",
            "What is your top priority right now?"]
BREAK_MSG = "BREAK: Rest the eyes!"
MSG_WAIT = 10 #in minutes
BREAK_WAIT = 29 #in minutes

def pick_message
  if break_time?
    @last_break = Time.now
    %Q("#{BREAK_MSG}")
  else
    %Q("#{MESSAGES[rand(MESSAGES.size - 1)]}")
  end
end

def send_message(msg)
  Output.send_notification msg
end

def wait_minutes(minutes)
  seconds = minutes * 60
  sleep seconds
end

def break_time?
  (Time.now - @last_break)/60 >= BREAK_WAIT
end

# main loop
@last_break = Time.now
loop do
  send_message(pick_message)
  wait_minutes MSG_WAIT
end