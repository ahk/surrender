module Surrender
  class Dispatcher
    attr_accessor :tasks
    
    def initialize()
      @tasks = []
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