module Surrender
  ##
  # Stores information for tasks that surrender is tracking
  class Task
    class MessageQueueEmpty < StandardError; self; end
    
    RANDOM_MESSAGES = ["Get back to work!",
                "Are you awake?",
                "Try some coffee if you haven't already",
                "What is your top priority right now?"]
    
    attr_accessor :start_time, :end_time, :reminder_frequency, :text, :message_queue
  
    def initialize(start_time = Time.now, end_time = Time.now, reminder_frequency = 300, text = "hello world!")
      @start_time = start_time
      @end_time = end_time
      @reminder_frequency = parse_reminder_frequency reminder_frequency
      @text = text
      @message_queue = []
    end
    
    def pick_ripest_message!
      raise MessageQueueEmpty, "'#{text}' is out of messages" if message_queue.empty?
      self.message_queue.shift if has_a_ripe_message?
    end
  
    private
    def parse_reminder_frequency(time)
      TimeDuration.parse time
    end
    
    def has_a_ripe_message?
      true if message_queue.first
    end
  end
end