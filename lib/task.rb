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
      @reminder_frequency = parse_reminder_frequency(reminder_frequency)
      @text = text
      @message_queue = []
    end
    
    def add_message(message)
      self.message_queue << message
    end
    
    def pick_ripe_messages!
      raise MessageQueueEmpty, "'#{text}' is out of messages" if message_queue.empty?
      
      ripe_msgs = []
      self.message_queue.each do |msg|
        if msg.is_ripe?
          ripe_msgs << msg
          queue_next_message_for msg
        end
      end
      
      self.message_queue -= ripe_msgs
      ripe_msgs
    end
  
    private
    def parse_reminder_frequency(time)
      TimeDuration.parse time
    end
    
    def queue_next_message_for(msg)
      self.add_message msg.next_message
    end
    
    def has_a_ripe_message?
      message_queue.first.time_to_display_at <= Time.now
    end
  end
end