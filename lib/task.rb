require 'yaml'
require 'time'

module Surrender
  ##
  # Stores information for tasks that surrender is tracking
  class Task
    class MessageQueueEmpty < Exception; self; end
    
    def self.load_yaml yaml
      tasks = YAML.load yaml
      tasks.map do |name,attrs|
        start    = Time.parse attrs['start_time']
        stop     = Time.parse attrs['end_time']
        text     = attrs['text']
        messages = Surrender::Message.load_hash attrs['messages']

        task = Surrender::Task.new( start, stop, text )
        messages.each {|msg| task.add_message msg}
        task
      end
    end
  
    attr_accessor :start_time, :end_time, :text, :message_queue
    alias_method :messages, :message_queue
  
    def initialize(start_time, end_time, text)
      @start_time = start_time
      @end_time = end_time
      @text = text
      @message_queue = []
    end
    
    def add_message(message)
      self.message_queue << message
      self
    end
    
    def tick!
      message_queue.each { |msg| msg.tick! }
    end
    
    def pick_ripe_messages!
      raise MessageQueueEmpty, "'#{text}' is out of messages" if message_queue.empty?
      
      ripe_msgs = []
      self.message_queue.each do |msg|
        if msg.ripe?
          ripe_msgs << msg
          queue_next_message_for msg
        end
      end
      
      # remove picked messages, but not in the middle of the iteration
      # I think this is a sign of me being a bad programmer.
      self.message_queue -= ripe_msgs
      ripe_msgs
    end
    
    # are any messages on the task ripe?
    def ripe?
      !!message_queue.detect {|msg| msg.ripe?}
    end
  
  private
    def queue_next_message_for(msg)
      self.add_message msg.next_message
    end
  end # Task
end # Surrender