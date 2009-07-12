module Surrender
  module Message
    class Base
      attr_accessor :seconds_to_next_message, :time_to_display_at
      
      def initialize(duration, time_to_fire = nil)
        self.seconds_to_next_message = duration
        self.time_to_display_at = ( time_to_fire || (Time.now + duration) )
      end
      
      def ==(a_message)
        is_equal = true
        is_equal = false if self.seconds_to_next_message != a_message.seconds_to_next_message
        is_equal = false if self.time_to_display_at != a_message.time_to_display_at
        is_equal
      end
    end
    
    class Reminder < Surrender::Message::Base
      def next_message
        next_msg_display_at_time = time_to_display_at + seconds_to_next_message
        self.class.new(self.seconds_to_next_message, next_msg_display_at_time)
      end
    end
    
    class Start < Surrender::Message::Base
    end
    
    class End < Surrender::Message::Base
    end
    
    class Warning < Surrender::Message::Base
    end
    
    class Stopwatch < Surrender::Message::Base
    end
  end
end