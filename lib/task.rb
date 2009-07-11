module Surrender
  ##
  # Stores information for tasks that surrender is tracking
  class Task
    RANDOM_MESSAGES = ["Get back to work!",
                "Are you awake?",
                "Try some coffee if you haven't already",
                "What is your top priority right now?"]
    
    attr_accessor :start_time, :end_time, :reminder_frequency, :text
  
    def initialize(start_time = Time.now, end_time = Time.now, reminder_frequency = 300, text = "hello world!")
      @start_time = start_time
      @end_time = end_time
      @reminder_frequency = parse_reminder_frequency reminder_frequency
      @text = text
    end
  
    private
    def parse_reminder_frequency(time)
      TimeDuration.parse time
    end
  end
end