require 'yaml'
require 'time'

module Surrender
  module Message
    def self.load_hash messages
      messages ||= []
      messages.map do |name, attrs|
        to_next = attrs['seconds_to_next_message']
        display_at = attrs['time_to_display_at']
        text = attrs['text']
        Surrender::Message::Reminder.new text, to_next, display_at
      end
    end
    
    class Base
      attr_accessor :seconds_to_next_message, :time_to_display_at, :text
      
      # text=String, wait_til_next=Integer or String, when_to_display=Time
      def initialize(text, wait_til_next = nil, when_to_display = nil)
        self.text = text
        if wait_til_next
          self.seconds_to_next_message = TimeDuration.parse(wait_til_next).seconds
          self.time_to_display_at = when_to_display || (Time.now + seconds_to_next_message)
        else
          self.time_to_display_at = Time.now
        end
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
        self.class.new(text, seconds_to_next_message, next_msg_display_at_time)
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