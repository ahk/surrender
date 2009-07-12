module Surrender
  module Message
    class Base
      attr_accessor :seconds_to_next_message, :time_to_display_at
      
      def initialize(wait_til_next, when_to_display = nil)
        # convert in case we received a TimeDuration rather than an integer
        wait_til_next = wait_til_next.seconds if wait_til_next.respond_to? :seconds
        
        self.seconds_to_next_message = wait_til_next
        self.time_to_display_at = when_to_display || (Time.now + wait_til_next)
      end
      
      def ==(a_message)
        is_equal = true
        is_equal = false if self.seconds_to_next_message != a_message.seconds_to_next_message
        is_equal = false if self.time_to_display_at != a_message.time_to_display_at
        is_equal
      end
      
      def is_ripe?
        self.time_to_display_at <= Time.now
      end
    end
    
    ##
    # Regular reminders at regular intervals
    class Reminder < Surrender::Message::Base
      def next_message
        next_msg_display_at_time = time_to_display_at + seconds_to_next_message
        self.class.new(self.seconds_to_next_message, next_msg_display_at_time)
      end
    end
    
    ##
    # When to start a task
    class Start < Surrender::Message::Base
    end
    
    ##
    # When to stop a task
    class End < Surrender::Message::Base
    end
    
    ##
    # When you are getting close to starting or stopping
    class Warning < Surrender::Message::Base
    end
    
    ##
    # Counting the amount of time since you began working on something
    class Stopwatch < Surrender::Message::Base
    end
  end
end