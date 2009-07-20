module Surrender
  class Dispatcher
    attr_accessor :tasks
    
    def initialize()
      @tasks = []
      @ripe_messages = []
    end
    
    def startup_message
      Message::Warning.new("You have surrendered ...")
    end
    
    def add_task(task)
      self.tasks << task
    end
    
    def harvest_messages
      tasks.each do |task|
        ripe = task.pick_ripe_messages!
        @ripe_messages.concat(ripe) unless ripe.empty?
      end
      @ripe_messages
    end

    def send_message(msg)
      Output.send_notification msg
    end
    
    # this is essentially the executable
    def main_loop
      send_message startup_message
      loop do
        harvest_messages
        @ripe_messages.each {|msg| send_message msg} unless @ripe_messages.nil?
        clear_ripe_messages!
        raise unless @ripe_messages.empty?
        sleep 1
      end
    end
    
    private
    def clear_ripe_messages!
      @ripe_messages.clear
    end
  end
end