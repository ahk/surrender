module Surrender
  class DefaultTasks
    RANDOM_MESSAGES = ["Get back to work!",
                "Are you awake?",
                "Try some coffee if you haven't already",
                "What is your top priority right now?"]
    
    class << self
      def awareness_task
        t =           Task.new( Time.now, Time.now, "10 minutes", "are you awake?" )
        t.add_message Message::Reminder.new( "\"are you awake?\"", "10 minutes", Time.now )
        t
      end
      
      def break_task
        t = Task.new Time.now, Time.now, "30 minutes", "REST YOUR EYES"
        t.add_message Message::Reminder.new "\"REST YOUR EYES\"", "30 minutes",Time.now 
        t
      end
    end
  end
end