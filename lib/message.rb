require 'yaml'
require 'time'

module Surrender
  module Message
    def self.load_hash messages
      messages ||= []
      messages.map do |name, attrs|
        ticks_to_next = attrs['seconds_to_next_message']
        text          = attrs['text']
        Surrender::Message::Reminder.new text, ticks_to_next
      end
    end
    
    class Base
      attr_accessor :text, :ticks, :ticks_til_ripe
      
      # text=String, wait_til_next=Integer or String
      def initialize(text, wait_til_next = nil)
        self.text  = text
        self.ticks = 0        
        self.ticks_til_ripe = TimeDuration.parse(wait_til_next).seconds if wait_til_next
      end
      
      def tick!
        self.ticks += 1
      end
      
      def ==(a_message)
        (self.ticks == a_message.ticks) &&
        (self.ticks_til_ripe == a_message.ticks_til_ripe)
      end
      
      # ripe when it's been ticked enough, 
      def is_ripe?
        self.ticks >= ticks_til_ripe
      end
    end
    
    ##
    # Regular reminders at regular intervals
    class Reminder < Surrender::Message::Base
      def next_message
        self.class.new( self.text, self.ticks_til_ripe )
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