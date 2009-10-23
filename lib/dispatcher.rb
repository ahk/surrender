module Surrender
  class Dispatcher
    attr_accessor :tasks, :startup_message
    
    def initialize()
      @tasks = []
      @ripe_messages = []
      @startup_message = Message::Warning.new("You have surrendered ...")
    end
    
    def add_task(task)
      self.tasks << task
    end
    
    # load tasks from YAML
    def load_tasks yaml
      tasks = Surrender::Task.load_yaml yaml
      tasks.each { |task| add_task task  }
    end
    
    def harvest_messages
      tasks.each do |task|
        task.tick!
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
      # will it run?
      SystemInfo.check_dependencies
      # let em know it's running
      send_message startup_message
      # run it!
      loop do
        harvest_messages
        @ripe_messages.each {|msg| send_message msg} unless @ripe_messages.nil?
        clear_ripe_messages!
        sleep 1
      end
    end
    
  private
    def clear_ripe_messages!
      @ripe_messages.clear
    end
  end
end