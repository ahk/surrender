module Surrender
  class Dispatcher
    #TODO this file used to contain the ENTIRE original program, must refactor this code 
    # out into the proper component libraries
    MESSAGES = ["Get back to work!",
                "Are you awake?",
                "Try some coffee if you haven't already.",
                "What is your top priority right now?"]
    BREAK_MSG = "BREAK: Rest the eyes!"
    MSG_WAIT = TimeDuration.new "10 minutes"
    BREAK_WAIT = TimeDuration.new "29 minutes"

    def self.pick_message
      if break_time?
        @last_break = Time.now
        %Q("#{BREAK_MSG}")
      else
        %Q("#{MESSAGES[rand(MESSAGES.size - 1)]}")
      end
    end

    def self.send_message(msg)
      Output.send_notification msg
    end

    def self.wait_minutes(minutes)
      seconds = minutes * 60
      sleep seconds
    end

    def self.break_time?
      (Time.now - @last_break)/60 >= BREAK_WAIT.seconds
    end

    # main loop
    @last_break = Time.now
    loop do
      send_message(pick_message)
      wait_minutes MSG_WAIT.seconds
    end
  end
end