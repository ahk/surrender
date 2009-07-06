##
# Stores information for tasks that surrender is tracking
class Task
  attr_accessor :start_time, :end_time, :reminder_frequency, :text
  
  def initialize(start_time = Time.now, end_time = Time.now, reminder_frequency = 300, text = "hello world!")
    @start_time = start_time
    @end_time = end_time
    @reminder_frequency = self.class.parse_reminder_frequency reminder_frequency
    @text = text
  end
  
  def self.parse_reminder_frequency(time_string)
    TimeDuration.parse_duration time_string
  end
end