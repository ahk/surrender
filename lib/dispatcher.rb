module Surrender
  class Dispatcher
    attr_accessor :tasks

    AWARENESS_TASK = Task.new "never", "never", "10 minutes", "wake up!"
    BREAK_TASK = Task.new "never", "never", "29 minutes", "BREAK: Rest the eyes!"
    
    def initialize()
      @tasks = []
      @tasks << AWARENESS_TASK
      @tasks << BREAK_TASK
      
      @ripe_messages = []
    end
    
    def add_task(task)
      self.tasks << task
    end
    
    def harvest_messages
      tasks.each do |task|
        ripe = task.pick_ripest_message!
        @ripe_messages << ripe if ripe
      end
      @ripe_messages
    end

    def send_message(msg)
      Output.send_notification msg
    end
    
    # this is essentially the executable
    def main_loop
      loop do
        harvest_messages
        @ripe_messages.each {|msg| send_message msg}
        sleep 1
      end
    end
  end
end